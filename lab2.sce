l_1 = [];
l_2 = [];
l_3 = [];
min_max_l1 = [];
min_max_l2 = [];
min_max_l3 = [];
mod_flag = 0;
mod_l_1 = [];
mod_l_2 = [];
mod_l_3 = [];
n = 22;
k = 1;
ci = [0; 0; 0];
cs = [];
me = 0;
min_x = [];
max_x = [];
not_pas = 0;
i = 1;

for lambd_1 = 0:1:k
    for lambd_2 = 0:1:n
        for lambd_3 = k:1:n
            Q = [
                    2 * lambd_1 0 0;
                    0       2 0;
                    0       0 4
                ];
            p = [0; -k; -n];
            C = [
                    1 lambd_2 1;
                    0 1       0;
                    1 0       2;
                ];
            b = [
                    18; 12; lambd_3
                ];
            [x,lagr,info] = qld(Q,p,C,b,ci,cs, me);
            F(i) = lambd_1 * x(1) * x(1) + x(2) * x(2) + 2 * x(3) * x(3) - k * x(2) - n * x(3);
            if info == 10
                then
                not_pas = not_pas + 1
                l_1(not_pas) = lambd_1;
                l_2(not_pas) = lambd_2;
                l_3(not_pas) = lambd_3;
            end
            min_max_l1(i) = lambd_1;
            min_max_l2(i) = lambd_2;
            min_max_l3(i) = lambd_3;
            if pmodulo(F, 1) == 0
                then
                mod_flag = mod_flag +1;
                mod_l_1(mod_flag) = lambd_1;
                mod_l_2(mod_flag) = lambd_2;
                mod_l_3(mod_flag) = lambd_3;
            end
            i = i + 1;
        end
    end
end
M = [F, min_max_l1, min_max_l2, min_max_l3];
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

printf('\nПри минимальном значении:');
Min_M = min(M, 'r');
printf('%f %f %f %f', Min_M);

printf('\nПри максимальном значении функции:');
Max_M =  max(M, 'r');
printf('%f %f %f %f', Max_M);

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
