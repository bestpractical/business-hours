use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Business::Hours',
    VERSION_FROM => 'lib/Business/Hours.pm', # finds $VERSION
    AUTHOR       => 'Jesse Vincent (jesse@cpan.org)',
    PREREQ_PM	=> { Test::Inline => 0,
		     Set::IntSpan => 0},
    ABSTRACT     => '',
);
