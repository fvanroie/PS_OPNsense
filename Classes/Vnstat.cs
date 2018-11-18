using System;
using System.Management.Automation;

namespace OPNsense.vnstat {
	public class General {
		#region Parameters
		public bool enabled { get; set; }
		public PSObject Interface { get; set; }
		#endregion Parameters

		public General () {
			enabled = true;
			Interface = null;
		}

		public General (
			byte Enabled,
			PSObject Interface_
		) {
			enabled = (Enabled == 0) ? false : true;
			Interface = Interface_;
		}
	}
}
