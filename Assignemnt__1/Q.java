public interface Behavior {
	public String act();
	public String reason();
	}

public class Human implements Behavior {
	public String type = "HUMAN.";
	public boolean empathy = true;
	
	public String act() {
		return "I am an human and I can act.";
	}

	public String reason() {
		return "I am a human and I can reason.";
	}
	
	public boolean hasEmpathy() {
		return empathy;
	}
}

public class Bladerunner extends Human {
	public String type = "BLADERUNNER.";
	public String rank;

	Bladerunner(){

	}
	
	Bladerunner (String r) {
		this.rank = r;

		String rank = "OFFICER.";
		System.out.println(rank);
	}

	public String reason() {
		return "I am bladerunner and I can reason.";
	} 
}


public abstract class Machine implements Behavior {
	
	public static String type = "MACHINE.";

}


public class Android extends Machine {
	public int version;
	
	Android (int version) {
		this.version = version;
	}

	public String whatIhave() {
		return "I have physical power.";
	}

	public static String whatIneed() {
		return "I need more time.";
	}

	public String act() {
		return "I am an android and I can act.";
	}

	public String reason() {
		return "I am an android and I can reason.";
	}
}

public interface Behavior2 {
	public boolean empathy = true;
	public boolean memories = true;
	public boolean hasEmpathy();
	public boolean hasMemories();
}

public class Android2 extends Android implements Behavior2 {
	Android2 (int version) {
		super(version);
	}

	Android2() {
		super(8);
	}

	public String whatIhave() {
		return "I have an infinite time.";
	}

	public boolean hasEmpathy() {
		return empathy;
	}

	public boolean hasMemories() {
		return memories;
	}
}