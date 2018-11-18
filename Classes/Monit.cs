using System;
using System.Management.Automation;

namespace OPNsense.monit {
	public class Alert {
		#region Parameters
		public string description { get; set; }
		public bool enabled { get; set; }
		public Object events { get; set; }
		public string format { get; set; }
		public bool noton { get; set; }
		public string recipient { get; set; }
		public uint reminder { get; set; }
		#endregion Parameters

		public Alert () {
			description = null;
			enabled = true;
			events = null;
			format = null;
			noton = true;
			recipient = "root@localhost.local";
			reminder = 10;
		}

		public Alert (
			string Description,
			byte Enabled,
			Object Events,
			string Format,
			byte Noton,
			string Recipient,
			uint Reminder
		) {
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			events = Events;
			format = Format;
			noton = (Noton == 0) ? false : true;
			recipient = Recipient;
			reminder = Reminder;
		}
	}
}
namespace OPNsense.monit {
	public class Service {
		#region Parameters
		public string address { get; set; }
		public bool enabled { get; set; }
		public PSObject Interface { get; set; }
		public string match { get; set; }
		public string name { get; set; }
		public string path { get; set; }
		public string pidfile { get; set; }
		public string start { get; set; }
		public string stop { get; set; }
		public PSObject tests { get; set; }
		public uint timeout { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Service () {
			address = null;
			enabled = true;
			Interface = null;
			match = null;
			name = null;
			path = null;
			pidfile = null;
			start = null;
			stop = null;
			tests = null;
			timeout = 300;
			type = null;
		}

		public Service (
			string Address,
			byte Enabled,
			PSObject Interface_,
			string Match,
			string Name,
			string Path,
			string Pidfile,
			string Start,
			string Stop,
			PSObject Tests,
			uint Timeout,
			PSObject Type
		) {
			address = Address;
			enabled = (Enabled == 0) ? false : true;
			Interface = Interface_;
			match = Match;
			name = Name;
			path = Path;
			pidfile = Pidfile;
			start = Start;
			stop = Stop;
			tests = Tests;
			timeout = Timeout;
			type = Type;
		}
	}
}
namespace OPNsense.monit {
	public class Test {
		#region Parameters
		public PSObject action { get; set; }
		public string condition { get; set; }
		public string name { get; set; }
		public string path { get; set; }
		#endregion Parameters

		public Test () {
			action = null;
			condition = null;
			name = null;
			path = null;
		}

		public Test (
			PSObject Action,
			string Condition,
			string Name,
			string Path
		) {
			action = Action;
			condition = Condition;
			name = Name;
			path = Path;
		}
	}
}
