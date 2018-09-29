using System;
using System.Management.Automation;

namespace wol {
	public class Wolentry {
		#region Parameters
		public string descr { get; set; }
		public PSObject Interface { get; set; }
		public string mac { get; set; }
		#endregion Parameters

		public Wolentry () {
			descr = null;
			Interface = null;
			mac = "00:00:00:00:00:00";
		}

		public Wolentry (
			string Descr,
			PSObject Interface_,
			string Mac
		) {
			descr = Descr;
			Interface = Interface_;
			mac = Mac;
		}
	}
}
