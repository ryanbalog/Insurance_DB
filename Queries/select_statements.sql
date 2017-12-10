/*Find the doctors who have not been seen for an appointment. This is important for an insurance provider when deciding to keep or drop a doctor*/

Select firstName, lastName, doctorType
From Providers
Where providerID not in (Select providerID From Service Group By providerID);

/*Which patients had cavities? May be important for marketing the right plans to the policy holders*/

Select M.firstName, M.lastName
From Account_Members as M join Service as S on M.policyAccountID = S.policyAccountID and M.memberID = S.memberID
Where S.serviceID in (Select serviceID From Service_Items Where ICD = 'K02.52');

/*Which members have not gone to a doctor yet?*/

Select M.firstName, M.lastName, S.serviceID
From Account_Members as M left join Service as S on M.policyAccountID = S.policyAccountID and M.memberID = S.memberID
Where S.serviceID is NULL;

/*Count of visits by doctor */

Create View DoctorVisits as
  SELECT providerID, count(providerID) AS 'numOfVisits'
  FROM Service
  GROUP BY providerID
;

Select firstName, lastName, numOfVisits
From Providers, DoctorVisits
Where Providers.providerID = DoctorVisits.providerID;
