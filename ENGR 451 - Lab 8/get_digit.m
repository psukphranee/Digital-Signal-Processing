function digit = get_digit(coords)
    keypad = ['1','2','3';'4','5','6';'7','8','9'; '*', '0', '#'];

    digit = keypad(coords(1), coords(2));
end