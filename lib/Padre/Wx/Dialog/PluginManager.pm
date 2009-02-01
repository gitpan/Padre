package Padre::Wx::Dialog::PluginManager;

use strict;
use warnings;
use Carp              ();
use Params::Util      qw{_INSTANCE};
use Padre::Wx         ();
use Padre::Wx::Dialog ();

our $VERSION = '0.26';

sub new {
	my $class   = shift;
	my $parent  = shift;
	my $manager = shift;
	unless ( _INSTANCE($manager, 'Padre::PluginManager') ) {
		Carp::croak("Missing or invalid Padre::PluginManager object");
	}

	# Create the object
	my $self = bless {
		parent  => $parent,
		manager => $manager,
		dialog  => undef,
	}, $class;

	return $self;
}

sub show {
	my $self = shift;

	# Create the layout
	my $plugins = $self->{manager}->plugins;
	my @names   = sort keys %$plugins;
	my @layout  = ();
	foreach my $name ( @names ) {
		my $object = $plugins->{$name}->{object};
		my $text   = $plugins->{$name}->plugin_name;
		push @layout, [
			[ 'Wx::StaticText', undef,       $text                       ],
			[ 'Wx::Button',    "able_$name", Wx::gettext('Incompatible') ],
			[ 'Wx::Button',    "pref_$name", Wx::gettext('Preferences')  ],
		];
	}

	# Create the dialog frame
	my $dialog = $self->{dialog} = Padre::Wx::Dialog->new(
		parent => $self->{parent},
		title  => Wx::gettext('Plugin Manager'),
		layout => \@layout,
		width  => [ 200, 100, 100 ],
	);
	foreach my $name ( @names ) {
		my $plugin = $plugins->{$name};
		my $object = $plugin->object;
		Wx::Event::EVT_BUTTON(
			$dialog,
			$dialog->{_widgets_}->{"pref_$name"},
			sub {
				$self->plugin_preferences($name);
			},
		);
		Wx::Event::EVT_BUTTON(
			$dialog,
			$dialog->{_widgets_}->{"able_$name"},
			sub {
				if ($plugin->error or $plugin->incompatible) {
					$self->{parent}->error( $plugin->errstr() );
				}
				else {
					$self->toggle_enabled($name);
				}
			},
		);
		unless ( $object and $object->can('plugin_preferences') ) {
			$dialog->{_widgets_}->{"pref_$name"}->Disable;
		}
		if ( $plugin->error || $plugin->incompatible and not $plugin->errstr ) {
			$dialog->{_widgets_}->{"able_$name"}->Disable;
		}
		$self->update_labels($name);
	}
	Wx::Event::EVT_BUTTON(
		$dialog,
		$dialog->{_widgets_}->{ok},
		sub {
			$dialog->EndModal(Wx::wxID_OK);
		},
	);

	# Show the dialog frame
	$dialog->show_modal;
	$dialog->Destroy;
	delete $self->{dialog};

	return;
}

sub plugin_preferences {
	my $self   = shift;
	my $name   = shift;
	my $object = $self->{manager}->plugins->{$name}->{object};
	if ( $object and $object->can('plugin_preferences') ) {
		$object->plugin_preferences;
	}
	return;
}

sub toggle_enabled {
	my $self    = shift;
	my $name    = shift;
	my $manager = $self->{manager};
	my $config  = $manager->parent->config;
	my $plugin  = $manager->plugins->{$name};
	$self->{parent}->Freeze;
	if ( $plugin->enabled ) {
		Padre::DB::Plugin->update_enabled(
			$plugin->class => 0,
		);
		$manager->_plugin_disable($name);
	} elsif ( $plugin->can_enable ) {
		Padre::DB::Plugin->update_enabled(
			$plugin->class => 1,
		);
		$manager->_plugin_enable($name);
	}
	$self->update_labels($name);
	$self->{parent}->menu->refresh;
	$self->{parent}->Thaw;
	return;
}

sub update_labels {
	my $self   = shift;
	my $name   = shift;
	my $dialog = $self->{dialog};
	my $plugin = $self->{manager}->plugins->{$name};

	if ( $plugin->enabled ) {
		$dialog->{_widgets_}->{"able_$name"}->SetLabel(Wx::gettext('Disable'));
		if ( $plugin->{object}->can('plugin_preferences') ) {
			$dialog->{_widgets_}->{"pref_$name"}->Enable;
		} else {
			$dialog->{_widgets_}->{"pref_$name"}->Disable;
		}
		return;
	}

	if ( $plugin->can_enable ) {
		$dialog->{_widgets_}->{"able_$name"}->SetLabel(Wx::gettext('Enable'));
		$dialog->{_widgets_}->{"able_$name"}->Enable;
		$dialog->{_widgets_}->{"pref_$name"}->Disable;
		return;
	}

	if ( $plugin->error ) {
		$dialog->{_widgets_}->{"able_$name"}->SetLabel(Wx::gettext('Crashed'));
		if ( $plugin->errstr ) {
			$dialog->{_widgets_}->{"able_$name"}->Enable;
		} else {
			$dialog->{_widgets_}->{"pref_$name"}->Disable;
		}
		$dialog->{_widgets_}->{"pref_$name"}->Disable;
		return;
	}

	if ( $plugin->incompatible ) {
		$dialog->{_widgets_}->{"able_$name"}->SetLabel(Wx::gettext('Crashed'));
		if ( $plugin->errstr ) {
			$dialog->{_widgets_}->{"able_$name"}->Enable;
		} else {
			$dialog->{_widgets_}->{"pref_$name"}->Disable;
		}
		$dialog->{_widgets_}->{"pref_$name"}->Disable;
		return;
	}

	$dialog->{_widgets_}->{"able_$name"}->SetLabel(Wx::gettext('Unknown'));
	$dialog->{_widgets_}->{"able_$name"}->Disable;
	$dialog->{_widgets_}->{"pref_$name"}->Disable;

	return;
}

1;
# Copyright 2008 Gabor Szabo.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.