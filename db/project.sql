create table cargos (
	id serial primary key,
  funcao text not null
);

insert into cargos (funcao) values ('Admin');
insert into cargos (funcao) values ('Gerente');
insert into cargos (funcao) values ('Estoque');
insert into cargos (funcao) values ('Consultor');
insert into cargos (funcao) values ('Cliente');

create table usuarios (
  id serial primary key,
  nome text not null,
  email text unique not null, 
  telefone text not null,
  cpf text unique not null,
  rua text null,
  bairro text null,
  cep text null,
  cidade text null,
  estado text null,
  senha text not null, 
  senhaResetToken text null,
  senhaResetTempo text null,
  agencia text null,
  conta text null,
  pix text null,
 	srcPerfil text null,
  srcCert text null,
  status text default 'inativo',
  totalFat decimal default 0.0,
  valorDispSaque decimal default 0.0,
  cargo_id int not null references cargos(id)
);

insert into usuarios (nome, cpf, email, telefone, senha, cargo_id) values (
	'BIODERMIS', '00000000000', 'adminbiodermis@biodermis.com', '00000000000', 'admin123', 1
);

create table formaspagamento (
	id serial primary key,
  forma text not null
);

insert into formaspagamento (forma) values ('pix');
insert into formaspagamento (forma) values ('credito');
insert into formaspagamento (forma) values ('debito');
insert into formaspagamento (forma) values ('boleto');


create table pedidos (
	id serial primary key,
  dataPedido text not null,
  valor decimal not null,
  valorconsult decimal not null,
  valorFrete decimal not null,
  formaEnvio text null,
  dataEnvio text null,
  codigoRastreio text null,
  rua text not null,
  numero text not null,
  bairro text not null,
  cep text not null,
  cidade text not null,
  estado text not null,
  complemento text not null,
  statuspag text default 'aguardando',
  statusentrega text default 'em andamento',
  modelo text not null,
  consultPago boolean default false,
  saldodisp boolean default false,
  resto decimal default 0.0,
  produtos_ids int array not null,
  linkPagamento text null,
  mercadopago_id text null,
  formapag_id int null references formaspagamento(id),
  cliente_id int not null references usuarios(id),
  consultor_id int not null references usuarios(id)
);

create table saques (
	id serial primary key,
  dataSaque text not null,
  valorSaque decimal not null,
  valorResto decimal not null,
  pedido_resto_id int not null,
  status text default 'pendente',
  srcComp text null,
  pedidos_ids int array not null,
  consultor_id int not null references usuarios(id)
);

create table categorias (
	id serial primary key,
  categoria text not null
);

create table produtos (
	id serial primary key,
  nome text not null,
  descricao text not null,
  valorMin decimal not null,
  valorMax decimal not null,
  valorVenda decimal not null,
  inativo boolean default false,
  mediaAvs decimal null default 0.0,
  estoque int default 0,
  altura decimal null,
  peso decimal null,
  largura decimal null,
  profundidade decimal null,
  imagens text array null,
  categoria_id int not null references categorias(id)
);

create table consultor_produtos(
  id serial primary key,
  produto_id int not null references produtos(id),
  consultor_id int not null references usuarios(id),
  valorConsult decimal not null,
  valorTotal decimal not null
);

create table avaliacoes (
	id serial primary key,
  comentario text not null,
  estrelas int not null,
  produto_id int not null references produtos(id)
);

create table movimentacoes (
	id serial primary key,
  tipo text not null,
  valor decimal not null,
  saque_id int unique null references saques(id),
  pedido_id int unique null references pedidos(id)
);





