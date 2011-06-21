package Padre::Wx::FBP::ModuleStarter;

# This module was generated by Padre::Plugin::FormBuilder::Perl.
# To change this module, edit the original .fbp file and regenerate.
# DO NOT MODIFY BY HAND!

use 5.008;
use strict;
use warnings;
use Padre::Wx ();
use Padre::Wx::Role::Main ();

our $VERSION = '0.86';
our @ISA     = qw{
	Padre::Wx::Role::Main
	Wx::Dialog
};

sub new {
	my $class  = shift;
	my $parent = shift;

	my $self = $class->SUPER::new(
		$parent,
		-1,
		Wx::gettext("Module Start"),
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
		Wx::wxDEFAULT_DIALOG_STYLE,
	);

	my $m_staticText4 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Module Name:"),
	);

	my $module = Wx::TextCtrl->new(
		$self,
		-1,
		"",
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
	);

	my $m_staticText8 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Author:"),
	);

	my $identity_name = Wx::TextCtrl->new(
		$self,
		-1,
		"",
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
	);

	my $m_staticText5 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Email Address:"),
	);

	my $identity_email = Wx::TextCtrl->new(
		$self,
		-1,
		"",
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
	);

	my $m_staticText6 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Builder:"),
	);

	my $module_starter_builder = Wx::Choice->new(
		$self,
		-1,
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
		[],
	);
	$module_starter_builder->SetSelection(0);

	my $m_staticText7 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("License:"),
	);

	my $module_starter_license = Wx::Choice->new(
		$self,
		-1,
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
		[],
	);
	$module_starter_license->SetSelection(0);

	my $m_staticline3 = Wx::StaticLine->new(
		$self,
		-1,
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	my $m_staticText3 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Parent Directory:"),
	);

	my $module_starter_directory = Wx::DirPickerCtrl->new(
		$self,
		-1,
		"",
		"Select a folder",
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
		Wx::wxDIRP_DEFAULT_STYLE,
	);

	my $m_staticline1 = Wx::StaticLine->new(
		$self,
		-1,
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	my $ok = Wx::Button->new(
		$self,
		Wx::wxID_OK,
		Wx::gettext("OK"),
	);
	$ok->SetDefault;

	my $cancel = Wx::Button->new(
		$self,
		Wx::wxID_CANCEL,
		Wx::gettext("Cancel"),
	);

	my $fgSizer1 = Wx::FlexGridSizer->new( 2, 2, 0, 10 );
	$fgSizer1->AddGrowableCol(1);
	$fgSizer1->SetFlexibleDirection(Wx::wxBOTH);
	$fgSizer1->SetNonFlexibleGrowMode(Wx::wxFLEX_GROWMODE_SPECIFIED);
	$fgSizer1->Add( $m_staticText4, 0, Wx::wxALIGN_CENTER_VERTICAL | Wx::wxALL, 5 );
	$fgSizer1->Add( $module, 0, Wx::wxALL | Wx::wxEXPAND, 5 );
	$fgSizer1->Add( $m_staticText8, 0, Wx::wxALIGN_CENTER_VERTICAL | Wx::wxALL, 5 );
	$fgSizer1->Add( $identity_name, 0, Wx::wxALL | Wx::wxEXPAND, 5 );
	$fgSizer1->Add( $m_staticText5, 0, Wx::wxALIGN_CENTER_VERTICAL | Wx::wxALL, 5 );
	$fgSizer1->Add( $identity_email, 0, Wx::wxALL | Wx::wxEXPAND, 5 );
	$fgSizer1->Add( $m_staticText6, 0, Wx::wxALIGN_CENTER_VERTICAL | Wx::wxALL, 5 );
	$fgSizer1->Add( $module_starter_builder, 0, Wx::wxALL | Wx::wxEXPAND, 5 );
	$fgSizer1->Add( $m_staticText7, 0, Wx::wxALIGN_CENTER_VERTICAL | Wx::wxALL, 5 );
	$fgSizer1->Add( $module_starter_license, 0, Wx::wxALL | Wx::wxEXPAND, 5 );

	my $buttons = Wx::BoxSizer->new(Wx::wxHORIZONTAL);
	$buttons->Add( $ok, 0, Wx::wxALL, 5 );
	$buttons->Add( 100, 0, 0, Wx::wxEXPAND, 5 );
	$buttons->Add( $cancel, 0, Wx::wxALL, 5 );

	my $vsizer = Wx::BoxSizer->new(Wx::wxVERTICAL);
	$vsizer->Add( $fgSizer1, 1, Wx::wxEXPAND, 5 );
	$vsizer->Add( $m_staticline3, 0, Wx::wxEXPAND | Wx::wxALL, 5 );
	$vsizer->Add( $m_staticText3, 0, Wx::wxALL, 5 );
	$vsizer->Add( $module_starter_directory, 0, Wx::wxALL | Wx::wxEXPAND, 5 );
	$vsizer->Add( $m_staticline1, 0, Wx::wxALL | Wx::wxEXPAND, 5 );
	$vsizer->Add( $buttons, 0, Wx::wxEXPAND, 5 );

	my $sizer = Wx::BoxSizer->new(Wx::wxHORIZONTAL);
	$sizer->Add( $vsizer, 1, Wx::wxALL | Wx::wxEXPAND, 5 );

	$self->SetSizer($sizer);
	$self->Layout;
	$sizer->Fit($self);

	$self->{module} = $module->GetId;
	$self->{identity_name} = $identity_name->GetId;
	$self->{identity_email} = $identity_email->GetId;
	$self->{module_starter_builder} = $module_starter_builder->GetId;
	$self->{module_starter_license} = $module_starter_license->GetId;
	$self->{module_starter_directory} = $module_starter_directory->GetId;

	return $self;
}

sub module {
	Wx::Window::FindWindowById($_[0]->{module});
}

sub identity_name {
	Wx::Window::FindWindowById($_[0]->{identity_name});
}

sub identity_email {
	Wx::Window::FindWindowById($_[0]->{identity_email});
}

sub module_starter_builder {
	Wx::Window::FindWindowById($_[0]->{module_starter_builder});
}

sub module_starter_license {
	Wx::Window::FindWindowById($_[0]->{module_starter_license});
}

sub module_starter_directory {
	Wx::Window::FindWindowById($_[0]->{module_starter_directory});
}

1;

# Copyright 2008-2011 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.

