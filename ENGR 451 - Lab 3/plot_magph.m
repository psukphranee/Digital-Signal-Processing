function plot_magph(x, w)
%magnitude plot
temp = mag_phase(dtft2(x,w));
%w = linspace(-1,1,length(w));

magPlot = subplot(2,1,1);
plot(w, real(temp.mag));

ylabel('|X(\omega)|');
grid(magPlot, 'on')
set(magPlot, 'XtickLabel', '');
xlim([-1 1]);

%phase plot
phasePlot = subplot(2,1,2);
plot(w,real(temp.phase)/pi);

ylabel('\angleX(\omega)');
grid(phasePlot, 'on')
xlim([-1 1]);
end