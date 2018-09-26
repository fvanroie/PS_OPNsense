using System;
using System.Management.Automation;

namespace OPNsense.netsnmp.user.users {
	public class User {
		#region Parameters
		public bool enabled { get; set; }
		public string enckey { get; set; }
		public string password { get; set; }
		public string username { get; set; }
		#endregion Parameters

		public User () {
			enabled = true;
			enckey = null;
			password = null;
			username = null;
		}

		public User (
			byte Enabled,
			string Enckey,
			string Password,
			string Username
		) {
			enabled = (Enabled == 0) ? false : true;
			enckey = Enckey;
			password = Password;
			username = Username;
		}
	}
}
