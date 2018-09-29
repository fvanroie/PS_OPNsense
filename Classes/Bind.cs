using System;
using System.Management.Automation;

namespace OPNsense.bind.acl.acls {
	public class Acl {
		#region Parameters
		public bool enabled { get; set; }
		public string name { get; set; }
		public PSObject networks { get; set; }
		#endregion Parameters

		public Acl () {
			enabled = true;
			name = null;
			networks = null;
		}

		public Acl (
			byte Enabled,
			string Name,
			PSObject Networks
		) {
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			networks = Networks;
		}
	}
}
