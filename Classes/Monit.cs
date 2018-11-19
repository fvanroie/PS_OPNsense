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
namespace OPNsense.monit {
	public class General {
		#region Parameters
		public bool enabled { get; set; }
		public string eventqueuePath { get; set; }
		public int eventqueueSlots { get; set; }
		public Object httpdAllow { get; set; }
		public bool httpdEnabled { get; set; }
		public string httpdPassword { get; set; }
		public ushort httpdPort { get; set; }
		public string httpdUsername { get; set; }
		public uint interval { get; set; }
		public string logfile { get; set; }
		public Object mailserver { get; set; }
		public bool mmonitRegisterCredentials { get; set; }
		public uint mmonitTimeout { get; set; }
		public string mmonitUrl { get; set; }
		public string password { get; set; }
		public ushort port { get; set; }
		public bool ssl { get; set; }
		public uint startdelay { get; set; }
		public string statefile { get; set; }
		public string username { get; set; }
		#endregion Parameters

		public General () {
			enabled = true;
			eventqueuePath = null;
			eventqueueSlots = 0;
			httpdAllow = null;
			httpdEnabled = true;
			httpdPassword = null;
			httpdPort = 2812;
			httpdUsername = null;
			interval = 120;
			logfile = "syslog facility log_daemon";
			mailserver = null;
			mmonitRegisterCredentials = true;
			mmonitTimeout = 5;
			mmonitUrl = null;
			password = null;
			port = 25;
			ssl = true;
			startdelay = 120;
			statefile = null;
			username = null;
		}

		public General (
			byte Enabled,
			string EventqueuePath,
			int EventqueueSlots,
			Object HttpdAllow,
			byte HttpdEnabled,
			string HttpdPassword,
			ushort HttpdPort,
			string HttpdUsername,
			uint Interval,
			string Logfile,
			Object Mailserver,
			byte MmonitRegisterCredentials,
			uint MmonitTimeout,
			string MmonitUrl,
			string Password,
			ushort Port,
			byte Ssl,
			uint Startdelay,
			string Statefile,
			string Username
		) {
			enabled = (Enabled == 0) ? false : true;
			eventqueuePath = EventqueuePath;
			eventqueueSlots = EventqueueSlots;
			httpdAllow = HttpdAllow;
			httpdEnabled = (HttpdEnabled == 0) ? false : true;
			httpdPassword = HttpdPassword;
			httpdPort = HttpdPort;
			httpdUsername = HttpdUsername;
			interval = Interval;
			logfile = Logfile;
			mailserver = Mailserver;
			mmonitRegisterCredentials = (MmonitRegisterCredentials == 0) ? false : true;
			mmonitTimeout = MmonitTimeout;
			mmonitUrl = MmonitUrl;
			password = Password;
			port = Port;
			ssl = (Ssl == 0) ? false : true;
			startdelay = Startdelay;
			statefile = Statefile;
			username = Username;
		}
	}
}
