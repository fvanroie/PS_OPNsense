using System;
using System.Management.Automation;

namespace OPNsense.ntopng {
	public class General {
		#region Parameters
		public PSObject dnsmode { get; set; }
		public bool enabled { get; set; }
		public PSObject httpport { get; set; }
		public PSObject Interface { get; set; }
		#endregion Parameters

		public General () {
			dnsmode = null;
			enabled = true;
			httpport = null;
			Interface = null;
		}

		public General (
			PSObject Dnsmode,
			byte Enabled,
			PSObject Httpport,
			PSObject Interface_
		) {
			dnsmode = Dnsmode;
			enabled = (Enabled == 0) ? false : true;
			httpport = Httpport;
			Interface = Interface_;
		}
	}
}
