using System;
using System.Management.Automation;

namespace OPNsense.shadowsocks {
	public class Local {
		#region Parameters
		public PSObject cipher { get; set; }
		public bool enabled { get; set; }
		public string localaddress { get; set; }
		public ushort localport { get; set; }
		public string password { get; set; }
		public string serveraddress { get; set; }
		public ushort serverport { get; set; }
		#endregion Parameters

		public Local () {
			cipher = null;
			enabled = true;
			localaddress = "127.0.0.1";
			localport = 1080;
			password = "password";
			serveraddress = "127.0.0.1";
			serverport = 8388;
		}

		public Local (
			PSObject Cipher,
			byte Enabled,
			string Localaddress,
			ushort Localport,
			string Password,
			string Serveraddress,
			ushort Serverport
		) {
			cipher = Cipher;
			enabled = (Enabled == 0) ? false : true;
			localaddress = Localaddress;
			localport = Localport;
			password = Password;
			serveraddress = Serveraddress;
			serverport = Serverport;
		}
	}
}
namespace OPNsense.shadowsocks {
	public class General {
		#region Parameters
		public PSObject cipher { get; set; }
		public bool enabled { get; set; }
		public ushort localport { get; set; }
		public string password { get; set; }
		public string serveraddress { get; set; }
		public ushort serverport { get; set; }
		#endregion Parameters

		public General () {
			cipher = null;
			enabled = true;
			localport = 1080;
			password = "password";
			serveraddress = "127.0.0.1";
			serverport = 8388;
		}

		public General (
			PSObject Cipher,
			byte Enabled,
			ushort Localport,
			string Password,
			string Serveraddress,
			ushort Serverport
		) {
			cipher = Cipher;
			enabled = (Enabled == 0) ? false : true;
			localport = Localport;
			password = Password;
			serveraddress = Serveraddress;
			serverport = Serverport;
		}
	}
}
