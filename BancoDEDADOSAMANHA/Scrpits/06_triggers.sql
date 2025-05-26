
ALTER TABLE pagamento_condominio ADD COLUMN IF NOT EXISTS ultima_alteracao TIMESTAMP;--aqui audita, atualiza/ modifica oq for preciso
CREATE OR REPLACE FUNCTION atualizar_ultima_alteracao()
RETURNS TRIGGER AS $$
BEGIN
  NEW.ultima_alteracao := NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_auditar_pagamento
BEFORE UPDATE ON pagamento_condominio
FOR EACH ROW
EXECUTE FUNCTION atualizar_ultima_alteracao();


CREATE OR REPLACE FUNCTION limpar_vagas_reservas_apos_deletar_morador()--------esse aqui apaga a vaga que estava ligada ao morador x ou seja duas tabelas estão aqui pra fazer ajuestes
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM vaga WHERE id_morador = OLD.id_morador;
  DELETE FROM reserva_area WHERE id_morador = OLD.id_morador;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_limpar_relacoes_morador
AFTER DELETE ON morador
FOR EACH ROW
EXECUTE FUNCTION limpar_vagas_reservas_apos_deletar_morador();


CREATE OR REPLACE FUNCTION bloquear_reserva_fora_exp()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status = 'Aprovada' AND (NEW.hora_inicio < TIME '06:00' OR NEW.hora_fim > TIME '22:00') THEN
    RAISE EXCEPTION 'Não é permitido aprovar reserva fora do horário das 6h às 22h';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_validar_horario_reserva
BEFORE UPDATE ON reserva_area
FOR EACH ROW
EXECUTE FUNCTION bloquear_reserva_fora_exp();