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
    public partial class IstorijaServisa : Form
    {
        public static int id;
        public static string naziv;
        public static string proi;
        public IstorijaServisa(int i,string n)
        {
            id = i;
            naziv = n;
          
            InitializeComponent();
        }

        private void IstorijaServisa_Load(object sender, EventArgs e)
        {
            label6.Text = "#" + id;
            label2.Text = naziv;
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            cmd.CommandText = "call proizvodjacOprema(" + id+");";
            MySqlDataReader read = cmd.ExecuteReader();
            while (read.Read())
            {
                label4.Text = read["Naziv"].ToString();

            }
            read.Close();
            MySqlCommand cmdd = konekcija.CreateCommand();
            cmdd.CommandText = "call istorijaServisa(" + id + "); ";
            MySqlDataReader readd = cmdd.ExecuteReader();
            var dataTable = new DataTable();
            dataTable.Load(readd);
            dataGridView1.DataSource = dataTable;
            dataGridView1.Columns[0].Visible = false;



        }
    }
}
