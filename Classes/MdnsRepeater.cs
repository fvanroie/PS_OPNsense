using System;
using System.Management.Automation;

namespace OPNsense {
	public class Mdnsrepeater {
		#region Parameters
		public bool enabled { get; set; }
		public PSObject interfaces { get; set; }
		#endregion Parameters

		public Mdnsrepeater () {
			enabled = true;
			interfaces = null;
		}

		public Mdnsrepeater (
			byte Enabled,
			PSObject Interfaces
		) {
			enabled = (Enabled == 0) ? false : true;
			interfaces = Interfaces;
		}
	}
}
