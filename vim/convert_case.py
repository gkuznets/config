def detect_case(s):
    if not s or '_' in s:
        return 'snake'
    if s[0].isupper():
        return 'upper_camel'
    return 'lower_camel'


def capitalize(s):
    return s[0].upper() + s[1:] if s else s


def split_at_uppers(s):
    parts = []
    left = 0
    right = 1
    while right < len(s):
        if s[right].isupper():
            parts.append(s[left:right])
            left = right
        right += 1

    parts.append(s[left:])

    return parts


def convert_case(s, from_case, to_case):
    parts = s.split('_') if from_case == 'snake' else split_at_uppers(s)

    if to_case == 'snake':
        return '_'.join(part.lower() for part in parts)

    upper_camel = ''.join(capitalize(part) for part in parts)
    if to_case == 'upper_camel':
        return upper_camel
    else:
        return upper_camel[0].lower() + upper_camel[1:]


def conver_to_next_case(s):
    if not s:
        return s

    next_case = {
        'snake': 'lower_camel',
        'lower_camel': 'upper_camel',
        'upper_camel': 'snake',
    }
    case = detect_case(s)
    return convert_case(s, case, next_case[case])


import vim
vim.command('normal "zyiw')
vim.command('normal ciw{}'.format(conver_to_next_case(vim.eval('@z'))))
