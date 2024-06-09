import sys

def generate_derangements(index, options_set):
    if not options_set:
        return [[]]
    results = []
    for option in options_set:
        if option == index:
            continue
        tmp_options = set(options_set)
        tmp_options.remove(option)
        subderangements = generate_derangements(index + 1, tmp_options)
        for subderangement in subderangements:
            results.append([option] + subderangement)

    return results 


def main(number):
    if number < 2:
        return 0
    derangements = generate_derangements(0, set(range(number)))
    for derangement in derangements:
        print(derangement)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python derangements.py <number>")
        sys.exit(1)
    main(int(sys.argv[1]))
