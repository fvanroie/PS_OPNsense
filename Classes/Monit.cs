using System;
using System.Management.Automation;

namespace OPNsense.Monit {
	public class Alert {
		#region Parameters
		public string description { get; set; }
		public bool enabled { get; set; }
		public Object events { get; set; }
		public string format { get; set; }
		public bool noton { get; set; }
		public string recipient { get; set; }
		public int reminder { get; set; }
		#endregion Parameters

		public Alert () {
			description = null;
			enabled = false;
			events = null;
			format = null;
			noton = false;
			recipient = null;
			reminder = 0;
		}

		public Alert (
			string Description,
			bool Enabled,
			Object Events,
			string Format,
			bool Noton,
			string Recipient,
			int Reminder
		) {
			description = Description;
			enabled = Enabled;
			events = Events;
			format = Format;
			noton = Noton;
			recipient = Recipient;
			reminder = Reminder;
		}
	}
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
		public PSObject type { get; set; }
		#endregion Parameters

		public Service () {
			address = null;
			enabled = false;
			Interface = null;
			match = null;
			name = null;
			path = null;
			pidfile = null;
			start = null;
			stop = null;
			tests = null;
			type = null;
		}

		public Service (
			string Address,
			bool Enabled,
			PSObject Interface_,
			string Match,
			string Name,
			string Path,
			string Pidfile,
			string Start,
			string Stop,
			PSObject Tests,
			PSObject Type
		) {
			address = Address;
			enabled = Enabled;
			Interface = Interface_;
			match = Match;
			name = Name;
			path = Path;
			pidfile = Pidfile;
			start = Start;
			stop = Stop;
			tests = Tests;
			type = Type;
		}
	}
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
