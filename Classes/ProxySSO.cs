using System;
using System.Management.Automation;

namespace OPNsense {
	public class Proxysso {
		#region Parameters
		public PSObject ADKerberosImplementation { get; set; }
		public bool EnableSSO { get; set; }
		public string KerberosHostName { get; set; }
		#endregion Parameters

		public Proxysso () {
			ADKerberosImplementation = null;
			EnableSSO = true;
			KerberosHostName = null;
		}

		public Proxysso (
			PSObject adkerberosimplementation,
			byte enablesso,
			string kerberoshostname
		) {
			ADKerberosImplementation = adkerberosimplementation;
			EnableSSO = (enablesso == 0) ? false : true;
			KerberosHostName = kerberoshostname;
		}
	}
}
