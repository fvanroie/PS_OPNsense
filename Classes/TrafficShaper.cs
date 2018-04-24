using System;
using System.Management.Automation;

namespace OPNsense.TrafficShaper {
	public class Pipe {
		#region Parameters
		public uint bandwidth { get; set; }
		public PSObject bandwidthMetric { get; set; }
		public uint buckets { get; set; }
		public bool codel_ecn_enable { get; set; }
		public bool codel_enable { get; set; }
		public uint codel_interval { get; set; }
		public uint codel_target { get; set; }
		public uint delay { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public uint fqcodel_flows { get; set; }
		public uint fqcodel_limit { get; set; }
		public uint fqcodel_quantum { get; set; }
		public PSObject mask { get; set; }
		public uint number { get; set; }
		public string origin { get; set; }
		public uint queue { get; set; }
		public PSObject scheduler { get; set; }
		#endregion Parameters

		public Pipe () {
			bandwidth = 0;
			bandwidthMetric = null;
			buckets = 0;
			codel_ecn_enable = true;
			codel_enable = true;
			codel_interval = 0;
			codel_target = 0;
			delay = 0;
			description = null;
			enabled = true;
			fqcodel_flows = 0;
			fqcodel_limit = 0;
			fqcodel_quantum = 0;
			mask = null;
			number = 0;
			origin = null;
			queue = 0;
			scheduler = null;
		}

		public Pipe (
			uint Bandwidth,
			PSObject BandwidthMetric,
			uint Buckets,
			bool Codel_Ecn_Enable,
			bool Codel_Enable,
			uint Codel_Interval,
			uint Codel_Target,
			uint Delay,
			string Description,
			bool Enabled,
			uint Fqcodel_Flows,
			uint Fqcodel_Limit,
			uint Fqcodel_Quantum,
			PSObject Mask,
			uint Number,
			string Origin,
			uint Queue,
			PSObject Scheduler
		) {
			bandwidth = Bandwidth;
			bandwidthMetric = BandwidthMetric;
			buckets = Buckets;
			codel_ecn_enable = Codel_Ecn_Enable;
			codel_enable = Codel_Enable;
			codel_interval = Codel_Interval;
			codel_target = Codel_Target;
			delay = Delay;
			description = Description;
			enabled = Enabled;
			fqcodel_flows = Fqcodel_Flows;
			fqcodel_limit = Fqcodel_Limit;
			fqcodel_quantum = Fqcodel_Quantum;
			mask = Mask;
			number = Number;
			origin = Origin;
			queue = Queue;
			scheduler = Scheduler;
		}
	}
}
namespace OPNsense.TrafficShaper {
	public class Queue {
		#region Parameters
		public uint buckets { get; set; }
		public bool codel_ecn_enable { get; set; }
		public bool codel_enable { get; set; }
		public uint codel_interval { get; set; }
		public uint codel_target { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public PSObject mask { get; set; }
		public uint number { get; set; }
		public string origin { get; set; }
		public PSObject pipe { get; set; }
		public uint weight { get; set; }
		#endregion Parameters

		public Queue () {
			buckets = 0;
			codel_ecn_enable = true;
			codel_enable = true;
			codel_interval = 0;
			codel_target = 0;
			description = null;
			enabled = true;
			mask = null;
			number = 0;
			origin = null;
			pipe = null;
			weight = 100;
		}

		public Queue (
			uint Buckets,
			bool Codel_Ecn_Enable,
			bool Codel_Enable,
			uint Codel_Interval,
			uint Codel_Target,
			string Description,
			bool Enabled,
			PSObject Mask,
			uint Number,
			string Origin,
			PSObject Pipe,
			uint Weight
		) {
			buckets = Buckets;
			codel_ecn_enable = Codel_Ecn_Enable;
			codel_enable = Codel_Enable;
			codel_interval = Codel_Interval;
			codel_target = Codel_Target;
			description = Description;
			enabled = Enabled;
			mask = Mask;
			number = Number;
			origin = Origin;
			pipe = Pipe;
			weight = Weight;
		}
	}
}
namespace OPNsense.TrafficShaper {
	public class Rule {
		#region Parameters
		public string description { get; set; }
		public PSObject destination { get; set; }
		public bool destination_not { get; set; }
		public PSObject direction { get; set; }
		public PSObject dst_port { get; set; }
		public PSObject Interface { get; set; }
		public PSObject interface2 { get; set; }
		public string origin { get; set; }
		public PSObject proto { get; set; }
		public uint sequence { get; set; }
		public PSObject source { get; set; }
		public bool source_not { get; set; }
		public PSObject src_port { get; set; }
		public PSObject target { get; set; }
		#endregion Parameters

		public Rule () {
			description = null;
			destination = null;
			destination_not = true;
			direction = null;
			dst_port = null;
			Interface = null;
			interface2 = null;
			origin = null;
			proto = null;
			sequence = 1;
			source = null;
			source_not = true;
			src_port = null;
			target = null;
		}

		public Rule (
			string Description,
			PSObject Destination,
			bool Destination_Not,
			PSObject Direction,
			PSObject Dst_Port,
			PSObject Interface_,
			PSObject Interface2,
			string Origin,
			PSObject Proto,
			uint Sequence,
			PSObject Source,
			bool Source_Not,
			PSObject Src_Port,
			PSObject Target
		) {
			description = Description;
			destination = Destination;
			destination_not = Destination_Not;
			direction = Direction;
			dst_port = Dst_Port;
			Interface = Interface_;
			interface2 = Interface2;
			origin = Origin;
			proto = Proto;
			sequence = Sequence;
			source = Source;
			source_not = Source_Not;
			src_port = Src_Port;
			target = Target;
		}
	}
}
