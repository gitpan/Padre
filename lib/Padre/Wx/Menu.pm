package Padre::Wx::Menu;

# Implements additional functionality to support richer menus

use strict;
use warnings;
use Padre::Action ();
use Padre::Wx     ();

use Class::Adapter::Builder
	ISA      => 'Wx::Menu',
	NEW      => 'Wx::Menu',
	AUTOLOAD => 'PUBLIC';

our $VERSION = '0.43';

use Class::XSAccessor getters => {
	wx => 'OBJECT',
};

# Default implementation of refresh

sub refresh {1}

# Overrides and then calls XS wx Menu::Append.
# Adds any hotkeys to global registry of bound keys
sub Append {
	my $self   = shift;
	my $string = $_[1];
	my $item   = $self->wx->Append(@_);
	my ($underlined) = ( $string =~ m/(\&\w)/ );
	my ($accel)      = ( $string =~ m/(Ctrl-.+|Alt-.+)/ );
	if ( $underlined or $accel ) {
		$self->{main}->{accel_keys} ||= {};
		if ($underlined) {
			$underlined =~ s/&(\w)/$1/;
			$self->{main}->{accel_keys}->{underlined}->{$underlined} = $item;
		}
		if ($accel) {
			my ( $mod, $mod2, $key ) = ( $accel =~ m/(Ctrl|Alt)(-Shift)?\-(.)/ );
			$mod .= $mod2 if ($mod2);
			$self->{main}->{accel_keys}->{hotkeys}->{ uc($mod) }->{ ord( uc($key) ) } = $item;
		}
	}
	return $item;
}

# Add a normal menu item to menu from a Padre action
sub add_menu_item {
	shift->_add_menu_item( 'Append', @_ );
}


# Add a checked menu item to menu from a Padre action
sub add_checked_menu_item {
	shift->_add_menu_item( 'AppendCheckItem', @_ );
}

# Add a radio menu item to menu from a Padre action
sub add_radio_menu_item {
	shift->_add_menu_item( 'AppendRadioItem', @_ );
}

# (Private method)
# Add a normal/checked/radio menu item to menu from a Padre action
sub _add_menu_item {
	my $self     = shift;
	my $method   = shift;
	my $menu     = shift;
	my $action   = Padre::Action->new(@_);
	my $name     = $action->name;
	my $shortcut = $action->shortcut;

	my $item = $menu->$method(
		$action->id,
		$action->label_menu,
	);
	Wx::Event::EVT_MENU(
		$self->{main},
		$item,
		$action->menu_event,
	);

	my $actions = Padre->ide->actions;
	if ( $actions->{$name} ) {
		warn "Found a duplicate action '$name'\n";
	}

	if ($shortcut) {
		foreach my $n ( keys %$actions ) {
			my $a = $actions->{$n};
			next unless $a->shortcut;
			next unless $a->shortcut eq $shortcut;
			warn "Found a duplicate shortcut '$shortcut' with " . $a->name . " for '$name'\n";
			last;
		}
	}

	$actions->{$name} = $action;

	return $item;
}

1;

# Copyright 2008-2009 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.
