package Padre::Constant;

# Constants used by various configuration systems.

use 5.008005;
use strict;
use warnings;
use Carp          ();
use File::Path    ();
use File::Spec    ();
use File::HomeDir ();

our $VERSION = '0.37';

# Convenience constants for the operating system
use constant WIN32 => !! ( $^O eq 'MSWin32' );
use constant MAC   => !! ( $^O eq 'darwin'  );
use constant UNIX  => !  ( WIN32 or MAC     );

# Padre targets the three largest Wx backends
# 1. Win32 Native
# 2. Mac OS X Native
# 3. Unix GTK
# The following defined reusable constants for these platforms,
# suitable for use in Wx platform-specific adaptation code.
# Currently (and a bit naively) we align these to the platforms.
use constant {
	WXWIN32 => WIN32,
	WXMAC   => MAC,
	WXGTK   => UNIX,
};

# The local newline type
use constant NEWLINE => WIN32 ? 'WIN' : MAC ? 'MAC' : 'UNIX';

# Setting Types (based on Firefox types)
use constant {
	BOOLEAN => 0,
	POSINT  => 1,
	INTEGER => 2,
	ASCII   => 3,
	PATH    => 4,
};

# Setting Storage Backends
use constant {
	HOST    => 0,
	HUMAN   => 1,
	PROJECT => 2,
};

# Syntax Highlighter Colours.
# Note: It's not clear why these need "PADRE_" in the name,
# but they do.
use constant {
	PADRE_BLACK    => 0,
	PADRE_BLUE     => 1,
	PADRE_RED      => 2,
	PADRE_GREEN    => 3,
	PADRE_MAGENTA  => 4,
	PADRE_ORANGE   => 5,
	PADRE_DIM_GRAY => 6,
	PADRE_CRIMSON  => 7,
	PADRE_BROWN    => 8,
};

# Files and Directories
use constant CONFIG_DIR => File::Spec->rel2abs(
	File::Spec->catdir(
		defined( $ENV{PADRE_HOME} ) ? ( $ENV{PADRE_HOME}, '.padre' )
		: ( File::HomeDir->my_data,
			File::Spec->isa('File::Spec::Win32') ? qw{ Perl Padre }
			: qw{ .padre }
		)
	)
);

use constant CONFIG_HUMAN => File::Spec->catfile( CONFIG_DIR, 'config.yml' );
use constant CONFIG_HOST  => File::Spec->catfile( CONFIG_DIR, 'config.db' );
use constant PLUGIN_DIR => File::Spec->catdir( CONFIG_DIR, 'plugins' );
use constant PLUGIN_LIB => File::Spec->catdir( PLUGIN_DIR, 'Padre', 'Plugin' );

# Check and create the directories that need to exist
unless ( -e CONFIG_DIR or File::Path::mkpath(CONFIG_DIR) ) {
	Carp::croak( "Cannot create config dir '" . CONFIG_DIR . "': $!" );
}
unless ( -e PLUGIN_LIB or File::Path::mkpath(PLUGIN_LIB) ) {
	Carp::croak( "Cannot create plugins dir '" . PLUGIN_LIB . "': $!" );
}

1;

__END__

=pod

=head1 NAME

Padre::Constant - constants used by config subsystems

=head1 SYNOPSIS

    use Padre::Constant ();
    [...]
    # do stuff with exported constants

=head1 DESCRIPTION

Padre uses various configuration subsystems (see C<Padre::Config> for more
information). Those systems needs to somehow agree on some basic stuff, which
is defined in this module.

=head1 CONSTANTS

=head2 BOOLEAN, POSINT, INTEGER, ASCII, PATH

Settings data types.

=head2 HOST, HUMAN, PROJECT

Settings storage backends.

=head2 BLACK, BLUE, RED, GREEN, MAGENTA, ORANGE, DIM_GRAY, CRIMSON, BROWN

Core supported colours.

=head2 CONFIG_HOST

DB configuration file storing host settings.

=head2 CONFIG_HUMAN

YAML configuration file storing user settings.

=head2 CONFIG_DIR

Private Padre configuration directory Padre, used to store stuff.

=head2 PLUGIN_DIR

Private directory where Padre can look for plugins.

=head2 PLUGIN_LIB

Subdir of PLUGIN_DIR with the path C<Padre/Plugin> added
(or whatever depending on your platform) so that perl can
load a C<Padre::Plugin::> plugin.

=head1 COPYRIGHT & LICENSE

Copyright 2008-2009 The Padre development team as listed in Padre.pm.

This program is free software; you can redistribute it and/or modify it under the
same terms as Perl 5 itself.

=cut

# Copyright 2008-2009 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.