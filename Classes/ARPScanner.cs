using System;
using System.Management.Automation;

namespace OPNsense.ARPscanner {
	public class General {
		#region Parameters
		public string Interface { get; set; }
		public string networks { get; set; }
		#endregion Parameters

		public General () {
			Interface = "lan";
			networks = null;
		}

		public General (
			string Interface_,
			string Networks
		) {
			Interface = Interface_;
			networks = Networks;
		}
	}
}
