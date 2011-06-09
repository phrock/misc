/*
 *
 *  Portions Copyright (C) 2009 wind (xihels@gmail.com)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <stdio.h>
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <X11/extensions/shape.h>

static int atoms_created = 0;
static Atom kde_wm_change_state;
static Atom _wm_protocols;
static Atom kwm_utf8_string;
static Atom net_wm_cm;
static void create_atoms( Display* dpy)
{
    if (!atoms_created){
	const int max = 20;
	Atom* atoms[max];
	const char* names[max];
	Atom atoms_return[max];
	int n = 0;

	atoms[n] = &kde_wm_change_state;
	names[n++] = "_KDE_WM_CHANGE_STATE";

        atoms[n] = &_wm_protocols;
        names[n++] = "WM_PROTOCOLS";

        atoms[n] = &kwm_utf8_string;
        names[n++] = "UTF8_STRING";

        char net_wm_cm_name[ 100 ];
        sprintf( net_wm_cm_name, "_NET_WM_CM_S%d", DefaultScreen( dpy ));
        atoms[n] = &net_wm_cm;
        names[n++] = net_wm_cm_name;

	// we need a const_cast for the shitty X API
	XInternAtoms( dpy, (char**)(names), n, 0, atoms_return );
	int i;
	for (i = 0; i < n; i++ )
	    *atoms[i] = atoms_return[i];

	atoms_created = 1;
    }
}


static int compositingActive()
{
	Display* dpy = XOpenDisplay( NULL );
	create_atoms( dpy );
	int ret = XGetSelectionOwner( dpy, net_wm_cm ) != None;
	XCloseDisplay( dpy );
	return ret;
}

int main(int argc, char* argv[])
{
	int i = 0;
	char* args[argc + 1];
	for (i = 0; i < argc; i++) {
		args[i] = argv[i];
	}
	args[0] = "/home/Aphrodite/bin/tilda";
	args[argc] = 0;
	for (i = 0; i < 30; i++) {
		 if (compositingActive())
			 execvp("tilda", args);
		sleep(1);
	}
	execvp("tilda", args);
}

