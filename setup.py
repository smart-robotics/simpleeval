import subprocess
from setuptools import setup

__version__ = '0.10.0'


def load_version():
    tag = subprocess.check_output(["git", "describe", "--tags"]).decode()
    if tag != __version__:
        raise ValueError("Please update version to {}".format(tag))
    return str(tag)


setup(
    name='simpleeval',
    py_modules=['simpleeval'],
    version=load_version(),
    description='A simple, safe single expression evaluator library.',
    long_description=open('README.rst', 'r').read(),
    long_description_content_type='text/x-rst',
    author='Daniel Fairhead',
    author_email='danthedeckie@gmail.com',
    url='https://github.com/danthedeckie/simpleeval',
    download_url='https://github.com/danthedeckie/simpleeval/tarball/' + __version__,
    keywords=['eval', 'simple', 'expression', 'parse', 'ast'],
    test_suite='test_simpleeval',
    use_2to3=True,
    classifiers=['Development Status :: 4 - Beta',
                 'Intended Audience :: Developers',
                 'License :: OSI Approved :: MIT License',
                 'Topic :: Software Development :: Libraries :: Python Modules',
                 'Programming Language :: Python',
                 ],
)
