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
    public partial class VracenaOpremaForma : Form
    {
        public VracenaOpremaForma()
        {
            InitializeComponent();
            this.Activated += new EventHandler(Form1_Activated);

        }
        void Form1_Activated(object sender, EventArgs e)
        {
            provjera();
        }

        public void provjera()
        {
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand c = konekcija.CreateCommand();
            c.CommandText = "select * from iznajmljivanjaSvihKorisnikaKojaNisuVracena;";
            MySqlDataReader read = c.ExecuteReader();
            var dataTable = new DataTable();
            dataTable.Load(read);
            dataGridView1.DataSource = dataTable;
            dataGridView1.Columns[0].Visible = false;
        }
        private void VracenaOpremaForma_Load(object sender, EventArgs e)
        {
            provjera();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                MySqlConnection konekcija = ConnectionPool.checkOutConnection();
                MySqlCommand cmdd = konekcija.CreateCommand();
                cmdd.CommandText = "update iznajmljivanje set DatumVracanja=current_date() where IdIznajmljivanja=" + int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()) + ";";
                cmdd.ExecuteNonQuery();
                MessageBox.Show("Uspješno ste izvršili upit! ");
            }
            else
                MessageBox.Show("Niste izabrali nijednu rezervaciju! ");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                String datumm = dataGridView1.CurrentRow.Cells[2].Value.ToString().Substring(0, 10);

                PrikazOpremaObuca pr = new PrikazOpremaObuca("IZNAJMLJIVANJE", int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()), datumm);
                pr.Show();
            }
            else
                MessageBox.Show("Niste izabrali nijednu rezervaciju! ");
        }
    }
}
