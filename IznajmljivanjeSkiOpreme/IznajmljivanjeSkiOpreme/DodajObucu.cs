using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace IznajmljivanjeSkiOpreme
{
    public partial class DodajObucu : Form
    {
        public DodajObucu()
        {
            InitializeComponent();
        }

        private void DodajObucu_Load(object sender, EventArgs e)
        {
            MySqlConnection connection = ConnectionPool.checkOutConnection();
            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "select IdProizvodjaca,Naziv from Proizvodjac;";
            MySqlDataReader reader = command.ExecuteReader();
            Dictionary<int, String> proizvodjaci = new Dictionary<int, string>();
            proizvodjaci.Add(0, "Izaberi proizvođaca");
            while (reader.Read())
            {
                proizvodjaci.Add(Int32.Parse(reader["IdProizvodjaca"].ToString()), reader["Naziv"].ToString());
            }
            comboBox1.DataSource = new BindingSource(proizvodjaci, null);
            comboBox1.DisplayMember = "Value";
            comboBox1.ValueMember = "Key";
            comboBox1.SelectedIndex = 0;
            reader.Close();
            MySqlCommand commandd = connection.CreateCommand();
            commandd.CommandText = "select IdTipa,Naziv from Tip;";
            MySqlDataReader readerr = commandd.ExecuteReader();
            Dictionary<int, String> tipovi = new Dictionary<int, string>();
            tipovi.Add(0, "Izaberi tip");
            while (readerr.Read())
            {
                tipovi.Add(Int32.Parse(readerr["IdTipa"].ToString()), readerr["Naziv"].ToString());
            }
            comboBox2.DataSource = new BindingSource(tipovi, null);
            comboBox2.DisplayMember = "Value";
            comboBox2.ValueMember = "Key";
            comboBox2.SelectedIndex = 0;
            connection.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            MySqlConnection connection = ConnectionPool.checkOutConnection();
            MySqlCommand command = connection.CreateCommand();
            int id_proizvodjaca = Int32.Parse(comboBox1.SelectedValue.ToString());
            int id_tipa = Int32.Parse(comboBox2.SelectedValue.ToString());

            command.CommandText = "insert into ski_obuca (Naziv, Boja, Cijena,Broj,IdProizvodjaca,IdTipa,Nedostupan) " +
                                  "values" +
                                  "('" + textBox1.Text + "', '" + textBox2.Text + "', '" + textBox3.Text + "', '"+ textBox4.Text + "', "+id_proizvodjaca+ ","+id_tipa+",0);";
            command.ExecuteNonQuery();
            connection.Close();
            MessageBox.Show("Uspjesno ste dodali novu obuću!");
            this.Dispose();
        }
    }
}
