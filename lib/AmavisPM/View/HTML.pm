package AmavisPM::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

AmavisPM::View::HTML - TT View for AmavisPM

=head1 DESCRIPTION

TT View for AmavisPM.

=head1 SEE ALSO

L<AmavisPM>

=head1 AUTHOR

Mail Domain Admin

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
