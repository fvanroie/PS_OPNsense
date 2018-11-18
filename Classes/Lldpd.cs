using System;
using System.Management.Automation;

namespace OPNsense.lldpd {
	public class General {
		#region Parameters
		public bool cdp { get; set; }
		public bool edp { get; set; }
		public bool enabled { get; set; }
		public bool fdp { get; set; }
		public string Interface { get; set; }
		public bool sonmp { get; set; }
		#endregion Parameters

		public General () {
			cdp = true;
			edp = true;
			enabled = true;
			fdp = true;
			Interface = null;
			sonmp = true;
		}

		public General (
			byte Cdp,
			byte Edp,
			byte Enabled,
			byte Fdp,
			string Interface_,
			byte Sonmp
		) {
			cdp = (Cdp == 0) ? false : true;
			edp = (Edp == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			fdp = (Fdp == 0) ? false : true;
			Interface = Interface_;
			sonmp = (Sonmp == 0) ? false : true;
		}
	}
}
