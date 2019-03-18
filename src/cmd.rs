use std::process::{self, Command};

pub fn run_command(cmd: &mut Command) -> Result<String, String> {
    let output = cmd.output();

    let output = match output {
        Ok(out) => out,
        _ => {
            return Err(String::from("Cannot get command output"));
        }
    };

    if output.status.success() {
        return Ok(String::from_utf8(output.stdout).unwrap());
    }

    return Err(String::from_utf8(output.stdout).unwrap());
}
