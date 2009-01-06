package Tkx::ROText;
use strict;
use warnings;

use Tkx;
use base qw(Tkx::widget);

our $VERSION = '0.01';

__PACKAGE__->_Mega("tkx_ROText");

sub _Populate {
	my $class  = shift;
	my $widget = shift;
	my $path   = shift;

	# create the widget
	my $self = $class->new($path)->_parent->new_text(-name => $path, @_);
	$self->_class($class);

	# Rename the widget to make it private
	Tkx::rename($self, $self . '.priv');

	# Replace handlers for the (public name of the) widget. Stubbing out
	# 'insert' and 'delete' makes it read-only. Everything else is passed
	# through to the private widget.
	Tkx::eval(<<EOT);
proc $self {args} [string map [list WIDGET $self] {
    switch [lindex \$args 0] {
        "insert" {}
        "delete" {}
        "default" { return [eval WIDGET.priv \$args] }
    }
}]
EOT

	return $self;
}


# Provide methods for programmatic insertions and deletions
sub insert { my $self = shift; Tkx::i::call($self . '.priv', 'insert', @_) }
sub delete { my $self = shift; Tkx::i::call($self . '.priv', 'delete', @_) }

1;

__END__

=pod

=head1 NAME

Tkx::ROText - Read-only Tkx text widget.

=head1 SYNOPSIS

    use Tkx::ROText;
    ...
    my $text = $parent->new_tkx_ROText();

=head1 DESCRIPTION

Tk doesn't have a read-only text widget which means that Tkx -- being a 
thin wrapper -- doesn't either. This module provides a text widget that 
is read-only (to the end-user) but which may be modified 
programatically. In all other ways it behaves as (and in fact is) a 
standard text widget.

=head1 BUGS

Please report any bugs or feature requests to C<bug-tkx-rotext at rt.cpan.org> 
or through the web interface at 
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tkx-ROText>. I will be 
notified, and then you'll automatically be notified of progress on your bug as I 
make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tkx::ROText

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tkx-ROText>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tkx-ROText>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tkx-ROText>

=item * Search CPAN

L<http://search.cpan.org/dist/Tkx-ROText>

=back

=head1 AUTHOR

Michael J. Carman, C<< <mjcarman at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Michael J. Carman, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
