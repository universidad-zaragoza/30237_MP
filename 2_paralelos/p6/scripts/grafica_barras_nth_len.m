function grafica_barras_nth_len(programas, datos, armonica, textoejex, textoejey, titulo, leyenda)
% datos =
%   #threads->  1       2       4       6       8
%       (000) valor1, valor2, valor3, valor4, valor5
%       (001) valor1, valor2, valor3, valor4, valor5
%           ...         ...             ...     ...
%       (111) valor1, valor2, valor3, valor4, valor5
%
% datos

% add average to data
% if (armonica == 1)
%     datos = [datos; 1./mean(1./datos)];
%     nrow = size(datos, 1);
%     programas = char(programas, ' HM');
% else
%     datos = [datos; mean(datos)];
%     nrow = size(datos, 1);
%     programas = char(programas, ' AM');
% end

nrow = size(datos, 1);
ncol = size(datos, 2);

figure;

set(gca,'box','off')
g1 = bar([1:nrow], datos);
set(gca,'Xtick',[2:3:nrow]);
% set(gca,'Xtick',[1:nrow]);
set(gca,'Xticklabel', programas);
% set(gca,'Ytick',[2,4,8,16,32,64,128,256,512,1024,2048,4096]);
set(gca,'FontSize',16,'fontname','Arial Narrow');
% set(findall(gcf,'type','text'),'FontSize',28,'fontname','Arial Narrow')
% set(gca,'XScale','linear','YScale','log');
set(gca,'XGrid','off','YGrid','on');
set(gca,'YMinorGrid','off','YMinorTick','off');
% set(gca,'XTick','off');
xlabel(textoejex);
ylabel(textoejey);
set(gca, 'Xlim', [0.3 nrow+0.7]);
set(gca, 'Ylim', [0 max(max(datos))*1.1]);
% axis([ 0 nrow+0.7 0 1.1*max(max(datos))]);
title(titulo);
legend(leyenda, 'Location','Best');

% for sensitivity to compiler,
% boxes and vertical lines to separate different loop lengths
nths=3;    % number of threads experiments
for k=1:nrow/nths
    if (k~=nrow/nths)
        line([nths*k + 0.5,nths*k + 0.5],ylim,'LineWidth',3,'Color',[.8 .8 .8]);
    end
end

yy = ylim;
texto = sprintf('nth=1/2/4');
text(nrow/2, yy(2)*0.8, texto, ...
    'edgecolor','k','backgroundcolor','w');

% if (ncol > 1)
%     if (datos(1,2)./datos(1,1) > 1.4)
%         speedup_type = 1; % pure ratio
%     else
%         speedup_type = 0; % percent
%     end
% else
%     speedup_type = 1;
% end

% speedups over 1 thread
% for k=1:ncol
%     if (speedup_type == 1)
%         speedup(:,k) = datos(:,k)./datos(:,1);
%     else
%         speedup(:,k) = datos(:,k)./datos(:,1);
%     end
% end
% speedups over 000
% switch ncol
%     case 2
%         posX = [-0.3, 0.15];
%     case 3
%         posX = [-0.02 : 0.22/(ncol-2) : 0.20];
%     case { 4, 5 }
%         posX = [-0.20 : 0.47/(ncol-2) : 0.27];
%     case { 6, 7, 8, 9 }
%         posX = [-0.32 : 0.6/(ncol-2) : 0.28];
%     otherwise
%         posX = [-0.35 : 0.65/(ncol-2) : 0.30];
% end

% for k=1:nrow
%     if (speedup_type == 1)
%         speedup(k,:) = datos(k,:)./datos(1,:);
%     else
%         speedup(k,:) = datos(k,:)./datos(1,:);
%     end
% end
% 
% switch ncol
%     case 1
%         posX = [ -0.1 ];
%     case 2
%         posX = [-0.3, 0.15];
%     case 3
%         posX = [-0.3 : 0.22/(ncol-2) : 0.20];
%     case { 4, 5 }
%         posX = [-0.38 : 0.5/(ncol-2) : 0.38];
%     case { 6, 7, 8, 9 }
%         posX = [-0.35 : 0.6/(ncol-2) : 0.35];
%     otherwise
%         posX = [-0.40 : 0.65/(ncol-2) : 0.30];
% end
%posX
% 
% offsetY = max(max(datos))/40;
% for m=1:nrow     % iterate over the clusters of bars
%     for k=1:ncol          % iterate over the bars in a cluster
%         posY = offsetY + datos(m,k);
%         texto = num2str(datos(m,k), '%2.2f');
%         % texto = num2str(speedup(m,k), '%2.1f');
%         t = text( m+posX(k), posY, ['\fontname{Arial Narrow}\fontsize{18}', texto]);
%         set(t, 'FontSize', 40);
%     end
% end

margenIzda=0.06;
margenAbajo=0.08;
ancho=1-1.1*margenIzda;
alto=1-margenAbajo*0.5-1.1*margenAbajo;
set(gca,'Position',[margenIzda margenAbajo ancho alto]);
% colormap(gray);
