USE `Restaurante`;

-- 1. Clientes
INSERT INTO Cliente (cpf, nome, endereco) VALUES 
('123.456.789-00', 'Carlos Silva', 'Rua das Flores, 123'),
('987.654.321-11', 'Ana Maria', 'Av. Central, 456'),
('555.444.333-22', 'Bruno Souza', 'Rua Chile, 789');

-- 2. Atendentes (Respeitando CHECK 100-999 e Auto-relacionamento idSenior)
-- Primeiro inserimos o Gerente (que é sênior de si mesmo ou não tem sênior acima)
INSERT INTO Atendente (idAtendente, idSenior, nome, salario) VALUES 
(100, 100, 'Roberto Gerente', '5000'),
(101, 100, 'João Garçom', '2500'),
(102, 101, 'Maria Garçonete', '2500');

-- 3. Telefones dos Atendentes
INSERT INTO TelefoneAtendente (Atendente_idAtendente, telefone) VALUES 
(100, '11 99999-0000'),
(101, '11 88888-1111'),
(101, '11 77777-2222'); -- Atendente com dois telefones

-- 4. Mesas (Respeitando CHECK 10-99)
INSERT INTO Mesa (idMesa, Cliente_idCliente) VALUES 
(10, 1),
(11, 2),
(20, 3);

-- 5. Pratos e Bebidas
INSERT INTO `Pratos/Bebidas` (nome, preco) VALUES 
('Feijoada Executiva', 45.90),
('Suco de Laranja 500ml', 12.00),
('Pudim de Leite', 15.00);

-- 6. Pedidos (A coluna 'duracao' será calculada automaticamente)
INSERT INTO Pedido (dataInicio, dataFim, Atendente_idAtendente, Cliente_idCliente) VALUES 
('12:00:00', '12:45:00', 101, 1), -- 45 min de duração (2700 seg)
('13:10:00', '14:00:00', 102, 2), -- 50 min de duração (3000 seg)
('19:00:00', '19:15:00', 101, 3); -- 15 min de duração (900 seg)

-- 7. Itens do Pedido (Relacionando Pratos aos Pedidos)
INSERT INTO itens (Pedido_idPedido, Pedido_Cliente_idCliente, `Pratos/Bebidas_idPratosBebidas`) VALUES 
(1, 1, 1), -- Pedido 1 levou Feijoada
(1, 1, 2), -- Pedido 1 levou Suco
(2, 2, 1); -- Pedido 2 levou Feijoada
