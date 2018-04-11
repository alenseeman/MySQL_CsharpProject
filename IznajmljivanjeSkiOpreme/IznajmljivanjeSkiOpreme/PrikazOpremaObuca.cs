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
    public partial class PrikazOpremaObuca : Form
    {
        public static int id;
        public static string rezervisanoZa;
        public static string vrstaa;
        public PrikazOpremaObuca(string vrsta, int i, string n)
        {
            vrstaa = vrsta;
            id = i;
            rezervisanoZa = n;
            InitializeComponent();
        }

        private void PrikazOpremaObuca_Load(object sender, EventArgs e)
        {
            label6.Text = "#" + id;
            radioButton4.Checked = true;
            if(vrstaa.Equals("IZNAJMLJIVANJE"))
            {
                label3.Text = "Datum iznajmljivanja:";
            }
            label2.Text = rezervisanoZa;
            provjera();
        }

        public void provjera()
        {
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmdd = konekcija.CreateCommand();
            if (vrstaa.Equals("IZNAJMLJIVANJE"))
            {//mijenjaj
                if (radioButton4.Checked) //obuca
                {
                    cmdd.CommandText = "call listaIznajmljeneObuceId(" + id + "); ";
                }
                else
                    cmdd.CommandText = "call listaIznajmljeneOpremeId(" + id + "); ";
            }
            else
            {
                if (radioButton4.Checked) //obuca
                {
                    cmdd.CommandText = "call listaRezervisaneObuceId(" + id + "); ";
                }
                else
                    cmdd.CommandText = "call listaRezervisaneOpremeId(" + id + "); ";
            }
            MySqlDataReader readd = cmdd.ExecuteReader();
            var dataTable = new DataTable();
            dataTable.Load(readd);
            dataGridView1.DataSource = dataTable;
            dataGridView1.Columns[0].Visible = false;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
        
        }

        private void radioButton4_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
        }
    }
}
