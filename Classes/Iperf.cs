using System;
using System.Management.Automation;

namespace OPNsense {
	public class Iperf3 {
		#region Parameters
		public PSObject Interface { get; set; }
		#endregion Parameters

		public Iperf3 () {
			Interface = null;
		}

		public Iperf3 (
			PSObject Interface_
		) {
			Interface = Interface_;
		}
	}
}
