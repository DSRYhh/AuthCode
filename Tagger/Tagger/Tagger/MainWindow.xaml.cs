using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Xml;
using System.Xml.Linq;

namespace Tagger
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private string TrainingSetPath = @"D:\Users Documents\Desktop\AuthCode\dataset";
        private int CurrentIndex;
        private Dictionary<string,string> dataList = new Dictionary<string, string>();
        private HashSet<int> taggedData = new HashSet<int>();
        public MainWindow()
        {
            InitializeComponent();
            if (!File.Exists("data.xml"))
            {
                File.Create("data.xml");
            }
            else
            {
                ReadFromDataFile();
            }

            if (taggedData.Count == 0)
            {
                CurrentIndex = 0;
            }
            else
            {
                CurrentIndex = taggedData.Max() + 1;
            }

            LoadFile(CurrentIndex);
            
        }

        private void TagBox_OnKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                dataList.Add($"{CurrentIndex}.jpg",TagBox.Text);
                taggedData.Add(CurrentIndex);
                UpdateDateFile($"{CurrentIndex}.jpg",TagBox.Text);
                LoadFile(++CurrentIndex);
            }
        }

        private void LoadFile(int index)
        {
            if (CurrentIndex == 999)
            {
                Hint.Text = "Tag completed.";
                return;
            }
            AuthCode.Source = new BitmapImage(new Uri(System.IO.Path.Combine(TrainingSetPath, $"{index}.jpg")));
            TagBox.Text = string.Empty;
            Hint.Text = $"{index}.jpg";
        }

        private void ReadFromDataFile()
        {
            using (XmlReader reader = XmlReader.Create(File.Open("data.xml",FileMode.Open)))
            {
                while (reader.Read())
                {
                    switch (reader.NodeType)
                    {
                        case XmlNodeType.Element:
                            if (reader.Name == "authcode")
                            {
                                dataList.Add(reader.GetAttribute("filename"),reader.GetAttribute("tag"));
                                string filename = reader.GetAttribute("filename");
                                filename = System.IO.Path.GetFileNameWithoutExtension(filename);
                                int index = -1;
                                int.TryParse(filename, out index);
                                taggedData.Add(index);
                            }
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        private void UpdateDateFile(string filename, string tag)
        {
            var contact = new XElement("authcode", new XAttribute("filename", filename), new XAttribute("tag", tag));
            var doc = new XDocument();
            doc = XDocument.Load("data.xml");
            doc.Element("data").Add(contact);
            doc.Save("data.xml");
        }
    }
}
