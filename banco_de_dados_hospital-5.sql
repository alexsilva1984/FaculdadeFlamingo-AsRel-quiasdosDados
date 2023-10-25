-- Consultando o banco
--

-- 1 
select *, AVG(valor_consulta) from consulta group by year(data_consulta) = 2020 having convenio_id;


-- 2 
select * from internacao where data_efet_alta > data_prev_alta;


-- 3 
select * from consulta inner join receita on consulta.id_consulta = receita.consulta_id inner join paciente 
on paciente.id_paciente = consulta.paciente_id 
order by receita.id_receita limit 1;


-- 4 
select *, MAX(valor_consulta), MIN(valor_consulta) from consulta group by convenio_id is null;


-- 5 
select *, DATEDIFF(data_efet_alta, data_entrada) dias_internado, tipo_quarto.valor_diario, DATEDIFF(data_efet_alta, data_entrada) * tipo_quarto.valor_diario valor_total from internacao inner join quarto 
on internacao.quarto_id = quarto.id_quarto inner join tipo_quarto 
on quarto.tipo_id = tipo_quarto.id_tipo;


-- 6 
select i.id_internacao, i.data_entrada, i.desc_procedimentos, q.numero from internacao i inner join quarto q 
on q.id_quarto = i.quarto_id where q.tipo_id = 1; 


-- 7 
select p.nome_paciente, c.data_consulta, e.nome_especialidade from consulta c inner join paciente p 
on p.id_paciente = c.paciente_id inner join especialidade e 
on e.id_especialidade = c.especialidade_id 
where c.especialidade_id <> 1 and year(c.data_consulta) - year(p.dt_nasc_paciente) < 19 and year(c.data_consulta) - year(p.dt_nasc_paciente) > 0 
order by c.data_consulta ;


-- 8 não vai
select p.nome_paciente, m.nome_medico, i.data_entrada, i.desc_procedimentos, q.id_quarto
from internacao i
inner join medico m 
on m.id_medico = i.medico_id
inner join paciente p
on p.id_paciente = i.paciente_id
inner join quarto q
on q.id_quarto = i.quarto_id
where q.tipo_id = 3 and m.especialidade_id = 3;


-- 9 
select m.nome_medico, m.crm, count(c.medico_id) as 'Qntd de consultas' from medico m inner join consulta c 
on c.medico_id = m.id_medico group by c.medico_id;


-- 10 
insert into medico(nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id, em_atividade) values('Gabriel Augusto', 45679312, 123456, 'gabriel.augusto@gmail.com', 'Especialista', 3, 'Ativo');
insert into endereco(logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values('R. Itapiru', 04143-010, 'Vila da Saúde', 'São Paulo', 'São Paulo', 11, null);
insert into telefone(ddd, numero, medico_id, paciente_id) values(11, 943658977, 11, null);

select * from medico where nome_medico like '%Alex%';


-- 11 
select enf.nome_enfermeiro, enf.cre, COUNT(p.enfermeiro_id) as Participacao from enfermeiro enf
inner join plantao p on p.enfermeiro_id = enf.id_enfermeiro group by enf.id_enfermeiro having Participacao > 1;