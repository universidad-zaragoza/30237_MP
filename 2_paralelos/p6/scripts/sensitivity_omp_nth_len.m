function sensitivity_omp_nth_len

clear; 
close all;

base_dir='./i5-3470/results/';
extension='.txt';

GFLOPs = 30; % number of operations executed in the program
% metric_text='ns/it';
metric_text='GFLOPS';
mean_type = 0; % 0 = ARITHMETIC
               % 1 = HARMONIC

loop='s001.pt.pablo';
compiler_list = { 'gcc-5' }; % compiler_list = { 'gcc-5', 'gcc-6' };
precision_list = {'single'}; % precision_list = { 'single', 'double' };
version_list = {'noavx.omp', 'avx.omp'};
% version_list = {'noavx.noomp', 'noavx.omp', 'avx.noomp', 'avx.omp'};
version_list_leyenda = {'OpenMP', 'AVX+OpenMP'};
% version_list_leyenda = {'base', 'OpenMP', 'AVX', 'AVX+OpenMP'};
nthread_list = {'1th', '2th', '4th'};  % len values
len_list = {'1k', '2k', '8k', '32k', '256k', '1024k'};  % len values

for i=1:length(compiler_list)
    compiler = compiler_list{i};

    for j=1:length(precision_list)
        precision = precision_list{j};
        directory_data = strcat(base_dir, 'data/');
        directory_figs = strcat(base_dir, precision, '/');
        if ~exist(directory_figs, 'dir')
            mkdir(directory_figs);
        end

        mat_data = [];

        for k = 1:length(version_list)
            version = version_list{k};
            cadena = sprintf('sensitivity.nth.len.%s.%s.%s.%s', loop, version, precision, compiler);
            % sensitivity.len.avx.omp.single.gcc-5.txt
            fichero = strcat(directory_data, cadena, extension);
            vec_data = load(fichero); % columns
            % for len j
            % array composed of the following rows
            % (len_1) val
            % (len_2) val
            %     ...
            % (len_n) val
            ncol = length(nthread_list)*length(len_list); % number of configurations (nthread_list*len_list values)
            if (length(vec_data) ~= ncol)
                fprintf(1, 'ERROR, incorrect number of points. Should be %d instead of %d\n', ncol, length(vec_data));
                return;
            end
    
            % fill data
            mat_data = [mat_data; vec_data'];
        end

        titulo = sprintf('%s: sensitivity to number of threads (%s)', loop, precision);
        grafica_barras_nth_len(len_list, mat_data', mean_type, 'tamaño del vector (1/2/4 threads)', metric_text, titulo, version_list_leyenda);
        cadena = sprintf('sensitivity.nth.len.%s.%s.vista1', loop, precision);
        filename_fig_barras = strcat(directory_figs, cadena, '.png');
        saveas(gcf, filename_fig_barras, 'png');

%         titulo = sprintf('%s: sensitivity to number of threads (%s)', loop, precision);
%         grafica_barras_nth_len(version_list_leyenda, mat_data, mean_type, 'numero de threads', metric_text, titulo, nthread_list);
%         cadena = sprintf('sensitivity.nth.len.%s.%s.vista2', loop, precision);
%         filename_fig_barras = strcat(directory_figs, cadena, '.png');
%         saveas(gcf, filename_fig_barras, 'png');        
        
        %mat_mean
    end
end

return

function m = media(datos, tipo)
% armónica o aritmetica
if (tipo == 1)
    m = 1./mean(1./datos);
else
    m = mean(datos);
end
