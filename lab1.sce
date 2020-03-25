not_pas = 0;
l_1 = [];
l_2 = [];
l_3 = [];
max_l_1 = 0;
max_l_2 = 0;
max_l_3 = 0;
min_l_1 = 0;
min_l_2 = 0;
min_l_3 = 0;
max_flag = 0;
min_flag = 0;
mod_flag = 0;
mod_l_1 = [];
mod_l_2 = [];
mod_l_3 = [];
n = 20;
min_xopt = [];
max_xopt = [];

for lambd_1 = 0:1:n
    for lambd_2 = 0:1:n
        for lambd_3 = 0:1:n
            c = [38; -60; -1; -4; -8];
            A = [lambd_1 4 2 0 -12
                0.4 3 -4.2 2 -lambd_3];
            Aeq =  [0 lambd_2 19 -7 10
                    2.1 13 -20 6 0];
            b = [86; 34];
            beq = [130; 18];
            lb = [0; 0; 0; 0; 0];
            [xopt,fopt, exitflag, iter, yopt] = karmarkar(Aeq, beq, c, [], [], [], [],[], A, b, lb);
            if (lambd_1 == 0) 
                if (lambd_2 == 0) 
                    if (lambd_3 == 0)
                        max_flag = fopt;
                        max_l_1 = lambd_1;
                        max_l_2 = lambd_2;
                        max_l_3 = lambd_3;
                        max_xopt = xopt;
                        min_flag = fopt; 
                        min_l_1 = lambd_1;
                        min_l_2 = lambd_2;
                        min_l_3 = lambd_3;
                        min_xopt = xopt;
                    end
                end
            end
            if exitflag <> 1
                not_pas = not_pas + 1;
                l_1(not_pas) = lambd_1;
                l_2(not_pas) = lambd_2;
                l_3(not_pas) = lambd_3;
            end
            if exitflag == 1
                if max_flag < fopt
                    then
                    max_flag = fopt;
                    max_l_1 = lambd_1;
                    max_l_2 = lambd_2;
                    max_l_3 = lambd_3;
                    max_xopt = xopt;
                end
                if min_flag > fopt
                    then
                    min_flag = fopt; 
                    min_l_1 = lambd_1;
                    min_l_2 = lambd_2;
                    min_l_3 = lambd_3;
                    min_xopt = xopt;
                end
            end
            if pmodulo(fopt, 1) == 0
                then
                mod_flag = mod_flag +1;
                mod_l_1(mod_flag) = lambd_1;
                mod_l_2(mod_flag) = lambd_2;
                mod_l_3(mod_flag) = lambd_3;
            end
        end
    end
end
printf('Набор параметров, при которых функция не имеет решения:\n');
if not_pas > 0
    then
        for i = 1:1:not_pas
            printf('  ----------------------------------------\n');
            printf('    %f\t', l_1(i));
            printf('%f\t', l_2(i));
            printf('%f\t', l_3(i));
            printf('\n');
        end
        printf('  ----------------------------------------\n');
   else
       printf('not search.\n');
end
printf('\nПри минимальном значении функции %f ', min_flag);
printf('значения параметров:\n');
printf('lambda_1 = %f, ', min_l_1);
printf('lambda_2 = %f, ', min_l_2);
printf('lambda_3 = %f.\n', min_l_3);
for i = 1:1:5
    printf('Значения X_%f = %f.\n', i, min_xopt(i));
end

printf('\nПри максимальном значении функции %f ', max_flag);
printf('значения параметров:\n');
printf('lambda_1 = %f, ', max_l_1);
printf('lambda_2 = %f, ', max_l_2);
printf('lambda_3 = %f.\n', max_l_3);
for i = 1:1:5
    printf('Значения X_%f = %f.\n', i, max_xopt(i));
end
if mod_flag > 0
    then
        if mod_flag == 1
            then
                printf('lambda_1 = %f,\n', mod_l_1(1));
                printf('lambda_1 = %f,\n', mod_l_2(1));
                printf('lambda_1 = %f.\n', mod_l_3(1));
                printf('\n');
            else
                printf('\nПараметры, при которых функция возвращает целочисленные значения: ');
                printf('\n');
                for i = 1:1:mod_flag
                    printf('  -------------------------------------------------------\n');
                    printf('\t%f\t', mod_l_1(i));
                    printf('%f\t', mod_l_2(i));
                    printf('%f\t', mod_l_3(i));
                    printf('\n');
                end
                printf('  -------------------------------------------------------\n');  
        end
    else
        printf('\nЦелочисленных решений нет');
end
