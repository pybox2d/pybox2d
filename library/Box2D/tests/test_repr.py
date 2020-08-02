#!/usr/bin/env python

import pytest

import Box2D


@pytest.mark.parametrize(
    'class_name, attrs',
    [pytest.param(cls, attrs, id=cls)
     for cls, attrs in Box2D.Box2D._repr_attrs.items()
     ]
)
def test_repr(class_name, attrs):
    cls = getattr(Box2D.Box2D, class_name)
    ignored = {'thisown', 'prev', 'next', 'world',
               }
    missing_attrs = {
        attr for attr in set(dir(cls)) - set(attrs)
        if not attr.startswith('_')
        and not attr.startswith('e_')
        and not attr.startswith('m_')
        and not callable(getattr(cls, attr))
        and attr not in ignored
    }
    bad_attrs = set(attrs) - set(dir(cls))

    print(class_name)
    if missing_attrs:
        print(class_name, 'Missing?', missing_attrs)
    if bad_attrs:
        print(class_name, 'Bad:', bad_attrs)
    if not bad_attrs:
        return

    raise ValueError(
        'Bad attrs: {} Maybe missing: {}'.format(bad_attrs, missing_attrs)
    )
