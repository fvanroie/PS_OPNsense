using System;
using System.Management.Automation;

namespace OPNsense.postfix.domain.domains {
	public class Domain {
		#region Parameters
		public string destination { get; set; }
		public string domainname { get; set; }
		public bool enabled { get; set; }
		#endregion Parameters

		public Domain () {
			destination = null;
			domainname = null;
			enabled = true;
		}

		public Domain (
			string Destination,
			string Domainname,
			byte Enabled
		) {
			destination = Destination;
			domainname = Domainname;
			enabled = (Enabled == 0) ? false : true;
		}
	}
}
namespace OPNsense.postfix.recipient.recipients {
	public class Recipient {
		#region Parameters
		public PSObject action { get; set; }
		public string address { get; set; }
		public bool enabled { get; set; }
		#endregion Parameters

		public Recipient () {
			action = null;
			address = null;
			enabled = true;
		}

		public Recipient (
			PSObject Action,
			string Address,
			byte Enabled
		) {
			action = Action;
			address = Address;
			enabled = (Enabled == 0) ? false : true;
		}
	}
}
namespace OPNsense.postfix.sender.senders {
	public class Sender {
		#region Parameters
		public PSObject action { get; set; }
		public string address { get; set; }
		public bool enabled { get; set; }
		#endregion Parameters

		public Sender () {
			action = null;
			address = null;
			enabled = true;
		}

		public Sender (
			PSObject Action,
			string Address,
			byte Enabled
		) {
			action = Action;
			address = Address;
			enabled = (Enabled == 0) ? false : true;
		}
	}
}
