extern crate clap;
use clap::{Arg, App};

fn main() {
    let matches = App::new("MyApp")
        .version("1.0")
        .author("Me")
        .about("Does awesome things")
        .arg(Arg::with_name("input")
            .short("i")
            .long("input")
            .value_name("FILE")
            .help("Sets the input file to use")
            .required(true)
            .takes_value(true))
        .get_matches();

    let input_file = matches.value_of("input").unwrap();
    println!("Using input file: {}", input_file);
}
