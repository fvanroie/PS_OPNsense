using System;
using System.Management.Automation;

namespace OPNsense.Cron {
	public class Job {
		#region Parameters
		public PSObject command { get; set; }
		public string days { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public string hours { get; set; }
		public string minutes { get; set; }
		public string months { get; set; }
		public string origin { get; set; }
		public string parameters { get; set; }
		public string weekdays { get; set; }
		public string who { get; set; }
		#endregion Parameters

		public Job () {
			command = null;
			days = "*";
			description = null;
			enabled = true;
			hours = "0";
			minutes = "0";
			months = "*";
			origin = "cron";
			parameters = null;
			weekdays = "*";
			who = "root";
		}

		public Job (
			PSObject Command,
			string Days,
			string Description,
			bool Enabled,
			string Hours,
			string Minutes,
			string Months,
			string Origin,
			string Parameters,
			string Weekdays,
			string Who
		) {
			command = Command;
			days = Days;
			description = Description;
			enabled = Enabled;
			hours = Hours;
			minutes = Minutes;
			months = Months;
			origin = Origin;
			parameters = Parameters;
			weekdays = Weekdays;
			who = Who;
		}
	}
}
