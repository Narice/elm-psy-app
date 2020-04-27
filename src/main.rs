extern crate rocket;
extern crate rocket_contrib;

#[cfg(test)]
mod tests;

use rocket_contrib::serve::StaticFiles;

fn rocket() -> rocket::Rocket {
    rocket::ignite().mount("/", StaticFiles::from("elm"))
}

fn main() {
    rocket().launch();
}
