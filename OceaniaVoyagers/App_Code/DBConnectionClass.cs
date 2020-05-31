using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;

/// <summary>
/// Summary description for DBConnectionClass
/// </summary>
public class DBConnectionClass
{
    SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["strtravel"].ConnectionString);

    public string s_p_Name1 = "";

	public DBConnectionClass()
	{
		
	}
    public DBConnectionClass(string pro_name)
    {
        this.s_p_Name1 = pro_name;
    }

    SqlTransaction sqlT;
    public bool SaveData(List<SqlParameter> str, string sp_name)
    {
        con.Open();
        sqlT = con.BeginTransaction();
        try
        {
            SqlCommand cmd = con.CreateCommand();
            cmd.Transaction = sqlT;
            cmd.CommandText = sp_name;
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            str.ToArray();
            for (int i = 0; i < str.Count; i += 1)
            {
                cmd.Parameters.Add(str[i]);
            }
            cmd.ExecuteNonQuery();
            sqlT.Commit();
            con.Close();
            return true;
        }
        catch (Exception e)
        {
            sqlT.Rollback();
            con.Close();
            return false;
        }
    }


    public string checkUserLogin(List<SqlParameter> str)
    {
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "CheckUserLogin";
            SqlParameter p1 = new SqlParameter();
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            str.ToArray();
            for (int i = 0; i < str.Count; i += 1)
            {
                cmd.Parameters.Add(str[i]);
            }
            SqlDataReader dataU = cmd.ExecuteReader();
            string s = "";
            while (dataU.Read())
            {
                s = dataU[0].ToString();
                break;
            }
            con.Close();
            return s;
        }
        catch (Exception e)
        {
            con.Close();
            return e.StackTrace.ToString();
        }
    }

    public DataTable DisplayData()
    {
        try
        {
            SqlCommand command = new SqlCommand();
            DataTable dt = new DataTable();
            SqlDataReader rd;
            con.Open();

            using (con)
            {
                SqlCommand cmd = new SqlCommand(s_p_Name1, con);
                cmd.CommandType = CommandType.StoredProcedure;
                rd = cmd.ExecuteReader();
                dt.Load(rd);
                rd.Close();
            }
            con.Close();
            return dt;
        }
        catch (Exception)
        {
            con.Close();
            DataTable empty = new DataTable();
            return empty;
        }
    }

    public DataTable DisplayDataParam(string TableName,string SelectFields,string WhereClouse)
    {
        try
        {
            SqlCommand command = new SqlCommand();
            DataTable dt = new DataTable();
            SqlDataReader rd;
            con.Open();

            SqlCommand cmd = new SqlCommand("SP_DisplayData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TableName", TableName);
            cmd.Parameters.AddWithValue("@SelectFields", SelectFields);
            cmd.Parameters.AddWithValue("@WhereClouse", WhereClouse);
            rd = cmd.ExecuteReader();
            dt.Load(rd);
            rd.Close();
            con.Close();
            return dt;
        }
        catch (Exception e)
        {
            con.Close();
            DataTable empty = new DataTable();
            return empty;
        }
    }

    public string DisplayDataParamSingle(string TableName, string SelectFields, string WhereClouse)
    {
        try
        {
            SqlCommand command = new SqlCommand();
            DataTable dt = new DataTable();
            string rd="";
            con.Open();

            SqlCommand cmd = new SqlCommand("SP_DisplayData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TableName", TableName);
            cmd.Parameters.AddWithValue("@SelectFields", SelectFields);
            cmd.Parameters.AddWithValue("@WhereClouse", WhereClouse);
            rd = cmd.ExecuteScalar().ToString();
            con.Close();
            return rd;
        }
        catch (Exception e)
        {
            con.Close();
            return "";
        }
    }

    public int CheckDuplicate(List<SqlParameter> str, string sp_name)
    {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = sp_name;
            SqlParameter p1 = new SqlParameter();
            str.ToArray();
            for (int i = 0; i < str.Count; i += 1)
            {
                cmd.Parameters.Add(str[i]);
            }

            string s = cmd.ExecuteScalar().ToString();

            con.Close();
            if (s == null || s == "" || Convert.ToInt32(s) == 0)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(s);
            }
    }

    public string HashPassword(string Password)
    {
        byte[] bytes = Encoding.Unicode.GetBytes(Password);
        byte[] inArray = HashAlgorithm.Create("SHA256").ComputeHash(bytes);
        return Convert.ToBase64String(inArray);
    }

    public void SetUpdateId(string valueId,string dataid)
    {
        WebConfigurationManager.AppSettings[valueId] = dataid;
    }

    public string GetUpdateId(string valueId)
    {
        return WebConfigurationManager.AppSettings[valueId].ToString();
    }

    public void EmptyUpdateId(string valueId)
    {
        WebConfigurationManager.AppSettings[valueId]=string.Empty;
    }

    public bool IsEmptyUpdateId(string valueId)
    {
        if (WebConfigurationManager.AppSettings[valueId].ToString() != string.Empty && WebConfigurationManager.AppSettings[valueId].ToString() != "None")
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public DataSet DisplayDataQuery(string str)
    {
        try
        {
            string chStr = str.Substring(0, 6);
            SqlCommand command = new SqlCommand();
            SqlDataAdapter adapter = new SqlDataAdapter();
            SqlCommandBuilder cb = new SqlCommandBuilder();
            DataSet ds = new DataSet();
            con.Open();
            command.Connection = con;
            command.CommandText = str;
            adapter.SelectCommand = command;
            cb.DataAdapter = adapter;
            adapter.Fill(ds);
            con.Close();
            return ds;
        }
        catch (Exception e)
        {
            con.Close();
            DataSet empty = new DataSet();
            return empty;
        }
    }

    public int CheckDuplicateByQuery(string sqlStr)
    {
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter = new SqlDataAdapter();
            SqlCommandBuilder cb = new SqlCommandBuilder();
            cmd.Connection = con;
            cmd.CommandText = sqlStr;
            adapter.SelectCommand = cmd;
            cb.DataAdapter = adapter;
            string s = cmd.ExecuteScalar().ToString();

            con.Close();
            if (s == null || s == "" || Convert.ToInt32(s) == 0)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(s);
            }
        }
        catch (Exception) { con.Close(); return 0; }
    }


    public long GetMaxCode(string sqlTable, string sqlField)
    {
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter = new SqlDataAdapter();
            SqlCommandBuilder cb = new SqlCommandBuilder();
            cmd.Connection = con;
            cmd.CommandText = "Select Max(" + sqlField + ") As " + sqlField + " from " + sqlTable + "";
            adapter.SelectCommand = cmd;
            cb.DataAdapter = adapter;
            string s = cmd.ExecuteScalar().ToString();

            con.Close();
            if (s == null || s == "" || Convert.ToInt64(s) == 0)
            {
                return 1;
            }
            else
            {
                return Convert.ToInt64(Convert.ToInt64(s) + 1);
            }
        }
        catch (Exception)
        {
            con.Close();
            return 0;
        }
    }

    public bool boolInsertData(string sqlQry)
    {
        try
        {
            con.Open();
            sqlT = con.BeginTransaction();
            
            SqlCommand cmd = con.CreateCommand();
            cmd.Transaction = sqlT;
            cmd.CommandText = sqlQry;
            int i = cmd.ExecuteNonQuery();
            sqlT.Commit();
            con.Close();
            if (i > 0)
                return true;
            else
                return false;
        }catch(Exception e)
        {
            sqlT.Rollback();
            con.Close();
            return false;
        }
    }


    public bool ExecuteData(List<SqlParameter> str, string s_p_Name1)
    {
        try
        {
            SqlCommand command = new SqlCommand();
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataSet ds = new DataSet();
            con.Open();
            sqlT = con.BeginTransaction();
            command.Connection = con;
            command.Transaction = sqlT;
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = s_p_Name1;
            SqlParameter p1 = new SqlParameter();
            str.ToArray();
            for (int i = 0; i < str.Count; i += 1)
            {
                command.Parameters.Add(str[i]);
            }
            command.ExecuteNonQuery();
            sqlT.Commit();
            con.Close();
            return true;
        }
        catch (Exception)
        {
            sqlT.Rollback();
            con.Close();
            return false;
        }
    }

    public DataSet DisplayData(List<SqlParameter> str, string s_p_Name1)
    {
        try
        {
            SqlCommand command = new SqlCommand();
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataSet ds = new DataSet();
            con.Open();
            command.Connection = con;
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = s_p_Name1;
            SqlParameter p1 = new SqlParameter();
            str.ToArray();
            for (int i = 0; i < str.Count; i += 1)
            {
                command.Parameters.Add(str[i]);
            }
            adapter = new SqlDataAdapter(command.Clone());
            adapter.Fill(ds);
            con.Close();
            return ds;
        }
        catch (Exception e)
        {
            con.Close();
            DataSet empty = new DataSet();
            return empty;
        }
    }
    
    public bool DeleteData(string FieldName,int FieldValue,string TableName)
    {
        con.Open();
        sqlT = con.BeginTransaction();
        try
        {
            SqlCommand cmd = con.CreateCommand();
            cmd.Transaction = sqlT;
            cmd.CommandText = "DeleteDataFromTable";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@FieldName", FieldName);
            cmd.Parameters.AddWithValue("@FieldValue", FieldValue);
            cmd.Parameters.AddWithValue("@TableName", TableName);
            cmd.ExecuteNonQuery();
            sqlT.Commit();
            con.Close();
            return true;
        }
        catch (Exception)
        {
            sqlT.Rollback();
            con.Close();
            return false;
        }
    }

    public string Encrypt(string clearText)
    {
        string EncryptionKey = "OCEANIAQUERTY123";
        byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] {
                0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                clearText = Convert.ToBase64String(ms.ToArray());
            }
        }
        return clearText;
    }

    public string Decrypt(string cipherText)
    {
        string EncryptionKey = "OCEANIAQUERTY123";
        cipherText = cipherText.Replace(" ", "+");
        byte[] cipherBytes = Convert.FromBase64String(cipherText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] {
                0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(cipherBytes, 0, cipherBytes.Length);
                    cs.Close();
                }
                cipherText = Encoding.Unicode.GetString(ms.ToArray());
            }
        }
        return cipherText;
    }
}
