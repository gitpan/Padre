package Padre::Wx::FBP::Breakpoints;

## no critic

# This module was generated by Padre::Plugin::FormBuilder::Perl.
# To change this module edit the original .fbp file and regenerate.
# DO NOT MODIFY THIS FILE BY HAND!

use 5.008005;
use utf8;
use strict;
use warnings;
use Padre::Wx ();
use Padre::Wx::Role::Main ();

our $VERSION = '0.98';
our @ISA     = qw{
	Padre::Wx::Role::Main
	Wx::Panel
};

sub new {
	my $class  = shift;
	my $parent = shift;

	my $self = $class->SUPER::new(
		$parent,
		-1,
		Wx::DefaultPosition,
		[ 195, 530 ],
		Wx::TAB_TRAVERSAL,
	);

	$self->{delete_not_breakable} = Wx::BitmapButton->new(
		$self,
		-1,
		Wx::NullBitmap,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::BU_AUTODRAW,
	);
	$self->{delete_not_breakable}->SetToolTip(
		Wx::gettext("Delete MARKER_NOT_BREAKABLE\nCurrent File Only")
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{delete_not_breakable},
		sub {
			shift->on_delete_not_breakable_clicked(@_);
		},
	);

	$self->{refresh} = Wx::BitmapButton->new(
		$self,
		-1,
		Wx::NullBitmap,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::BU_AUTODRAW,
	);
	$self->{refresh}->SetToolTip(
		Wx::gettext("Refresh List")
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{refresh},
		sub {
			shift->on_refresh_click(@_);
		},
	);

	$self->{set_breakpoints} = Wx::BitmapButton->new(
		$self,
		-1,
		Wx::NullBitmap,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::BU_AUTODRAW,
	);
	$self->{set_breakpoints}->SetToolTip(
		Wx::gettext("Set Breakpoints (toggle)")
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{set_breakpoints},
		sub {
			shift->on_set_breakpoints_clicked(@_);
		},
	);

	$self->{list} = Wx::ListCtrl->new(
		$self,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::LC_REPORT | Wx::LC_SINGLE_SEL,
	);

	Wx::Event::EVT_LIST_ITEM_SELECTED(
		$self,
		$self->{list},
		sub {
			shift->_on_list_item_selected(@_);
		},
	);

	$self->{show_project} = Wx::CheckBox->new(
		$self,
		-1,
		Wx::gettext("project"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);
	$self->{show_project}->SetToolTip(
		Wx::gettext("show breakpoints in project")
	);

	Wx::Event::EVT_CHECKBOX(
		$self,
		$self->{show_project},
		sub {
			shift->on_show_project_click(@_);
		},
	);

	$self->{delete_project_bp} = Wx::BitmapButton->new(
		$self,
		-1,
		Wx::NullBitmap,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::BU_AUTODRAW,
	);
	$self->{delete_project_bp}->SetToolTip(
		Wx::gettext("Delete all project Breakpoints")
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{delete_project_bp},
		sub {
			shift->on_delete_project_bp_clicked(@_);
		},
	);

	my $button_sizer = Wx::BoxSizer->new(Wx::HORIZONTAL);
	$button_sizer->Add( $self->{delete_not_breakable}, 0, Wx::ALL, 5 );
	$button_sizer->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$button_sizer->Add( $self->{refresh}, 0, Wx::ALL, 5 );
	$button_sizer->Add( $self->{set_breakpoints}, 0, Wx::ALL, 5 );

	my $checkbox_sizer = Wx::StaticBoxSizer->new(
		Wx::StaticBox->new(
			$self,
			-1,
			Wx::gettext("Show"),
		),
		Wx::HORIZONTAL,
	);
	$checkbox_sizer->Add( $self->{show_project}, 0, Wx::ALL, 2 );
	$checkbox_sizer->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$checkbox_sizer->Add( $self->{delete_project_bp}, 0, Wx::ALL, 5 );

	my $bSizer10 = Wx::BoxSizer->new(Wx::VERTICAL);
	$bSizer10->Add( $button_sizer, 0, Wx::EXPAND, 5 );
	$bSizer10->Add( $self->{list}, 1, Wx::ALL | Wx::EXPAND, 5 );
	$bSizer10->Add( $checkbox_sizer, 0, Wx::EXPAND, 5 );

	$self->SetSizer($bSizer10);
	$self->Layout;

	return $self;
}

sub on_delete_not_breakable_clicked {
	$_[0]->main->error('Handler method on_delete_not_breakable_clicked for event delete_not_breakable.OnButtonClick not implemented');
}

sub on_refresh_click {
	$_[0]->main->error('Handler method on_refresh_click for event refresh.OnButtonClick not implemented');
}

sub on_set_breakpoints_clicked {
	$_[0]->main->error('Handler method on_set_breakpoints_clicked for event set_breakpoints.OnButtonClick not implemented');
}

sub _on_list_item_selected {
	$_[0]->main->error('Handler method _on_list_item_selected for event list.OnListItemSelected not implemented');
}

sub on_show_project_click {
	$_[0]->main->error('Handler method on_show_project_click for event show_project.OnCheckBox not implemented');
}

sub on_delete_project_bp_clicked {
	$_[0]->main->error('Handler method on_delete_project_bp_clicked for event delete_project_bp.OnButtonClick not implemented');
}

1;

# Copyright 2008-2013 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.

