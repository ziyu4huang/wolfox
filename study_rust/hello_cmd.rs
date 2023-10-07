extern crate getopts;
use getopts::Options;
use std::env;

pub(crate) fn main() {
    let args: Vec<String> = env::args().collect();
    let mut opts = Options::new();
    opts.optflag("h", "help", "Print this help menu");

    let matches = match opts.parse(&args[1..]) {
        Ok(m) => m,
        Err(f) => panic!(f.to_string()),
    };

    if matches.opt_present("h") {
        println!("Usage: {} [options]", args[0]);
        return;
    }
    //println!(matches);
}
