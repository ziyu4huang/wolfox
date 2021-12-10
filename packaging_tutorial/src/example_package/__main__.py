import logging
import example_package.example
import example_package.my_pkg


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format='[%(asctime)s][%(name)s] {%(pathname)s:%(lineno)d} %(levelname)s - %(message)s',
        datefmt='%H:%M:%S'
    )
    example_package.example.main()
    example_package.my_pkg.foo()
