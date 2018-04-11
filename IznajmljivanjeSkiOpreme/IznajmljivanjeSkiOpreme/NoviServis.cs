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
    public partial class NoviServis : Form
    {
        public static int id;
        public static string naziv;
        public static string idservisera;
        public Form forma;
        public NoviServis(int i,string n,string jmbg,Form f)
        {
            id = i;
            naziv = n;
            idservisera = jmbg;
            forma = f;
            //f.Hide();
            InitializeComponent();
        }

        private void NoviServis_Load(object sender, EventArgs e)
        {
            textBox2.Text = naziv;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            cmd.CommandText = "insert into servisiranje (DatumServisiranja,IdOpreme,JMBGZaposleni,Opis) values(current_date()," + id + "," + idservisera + ",'" + textBox1.Text.ToString() + "');";
            if(cmd.ExecuteNonQuery().ToString().Equals("1"))
            MessageBox.Show("Uspješno ste dodali servis !");
            konekcija.Close();
            //forma.Show();
            this.Dispose();
            

        }
    }
}
