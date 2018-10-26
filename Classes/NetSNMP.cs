using System;
using System.Management.Automation;

namespace OPNsense.netsnmp.user.users {
	public class User {
		#region Parameters
		public bool enabled { get; set; }
		public string enckey { get; set; }
		public string password { get; set; }
		public bool readwrite { get; set; }
		public string username { get; set; }
		#endregion Parameters

		public User () {
			enabled = true;
			enckey = null;
			password = null;
			readwrite = true;
			username = null;
		}

		public User (
			byte Enabled,
			string Enckey,
			string Password,
			byte Readwrite,
			string Username
		) {
			enabled = (Enabled == 0) ? false : true;
			enckey = Enckey;
			password = Password;
			readwrite = (Readwrite == 0) ? false : true;
			username = Username;
		}
	}
}
