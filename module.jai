#import "Basic";
#insert #run loadex("test.jai");

main :: () {
    print("Hello World!\n");
    print("foo(2.0) = %\n", foo(2.0));
}

loadex :: (filename: string, replacement_filename: string = "", debug := false) -> string {
    #import "File";
    #import "String";

    rfn := ifx replacement_filename.count == 0 then
        join(#filepath, "replacements.txt");
    else
        replacement_filename;

    if debug print("replacement file: \"%\"\n", rfn);

    replacements_file := read_entire_file(rfn);
    replacement_lines := split(replacements_file, "\n");

    R := replacement_lines.count;
    idnt := NewArray(R, string); defer array_free(idnt);
    reps := NewArray(R, string); defer array_free(reps);

    for replacement_lines {
        found : bool = ---;
        found, idnt[it_index], reps[it_index] = split_from_left(it, ":");
        assert(found, "improper replacement file");
        idnt[it_index] = trim(idnt[it_index], " \t\n\r");
        reps[it_index] = trim(reps[it_index], " \t\n\r");
    }

    file_text := read_entire_file(filename);
    if debug {
        print("loaded file '%':\n", filename);
        print("%\n", file_text);
    }

    for i:0..R-1 {
        if debug print("replacing % -> %", idnt[i], reps[i]);
        ntxt, occ := replace(file_text, idnt[i], reps[i]);
        if debug print(" : % occurences\n", occ);
        free(file_text);
        file_text = ntxt;
    }    

    if debug {
        print("replaced file '%':\n", filename);
        print("%\n", file_text);
    }

    new_filename := sprint("replaced/%", filename);
    write_entire_file(new_filename, file_text);

    return sprint("#load \"%\";", new_filename);
}