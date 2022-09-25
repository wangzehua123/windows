namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private void button1_Click(object sender , EventArgs e)
        {
            string temp = null, tempType = null;
            object displayName = null, uninstallString = null, releaseType = null;
            RegistryKey currentKey = null;
            int softNum = 0;
            RegistryKey pregkey =
            Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Uninstall");  #V获取指定路径下的键
            try
            {
            foreach(string item in pregkey.GetSubKeyNames()  #循环所有子键
            {
                currentKey = pregkey.OpenSubKey(item);
                displayName = currentKey.GetValue("DisplayName"); #获取显示名称
                uninstallString = currentKey.GetValue("UninstallString");  #获取卸载字符串路径
                releaseType = currentKey.GetValue("ReleaseType");  #发行类型，值是Security Update为安全更新，Update为更新
                bool isSecurityUpdate=false;

                if(releaseType != null)
                {
                    tempType = releaseType.ToString();
                    if(tempType == "Security Update" || tempType == "Update")
                    isSecurityUpdate = true;
                }
                if(!isSecurityUpdate && displayName != null && uninstallString != null)
                {
                    softNum++;
                    temp += displayName.ToString()+ Environment.NewLine;
                }
            }
        }
        catch (Exception E)
        {
            MessageBox.Show(E.Message.ToString());
        }
        tbSoftWare.Text = "共有软件" ＋ softNum.ToString() + "个" + Environment.NewLine + temp;
        pregkey.Close();
    }
}


